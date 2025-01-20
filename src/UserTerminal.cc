#include <omnetpp.h>
#include <cmath>
#include "inet/networklayer/contract/IRoutingTable.h"
#include "inet/networklayer/ipv4/Ipv4Route.h"
#include "inet/linklayer/common/MacAddressTag_m.h"
#include "inet/common/ModuleAccess.h"

using namespace omnetpp;
using namespace inet;

class UserTerminal : public cSimpleModule {
  private:
    cMessage *pingTimer;       // Timer for periodic pings
    double antennaRange;       // Antenna range (read from parameters)
    cModule *closestSatellite; // Closest satellite in range

  public:
    UserTerminal() : pingTimer(nullptr), closestSatellite(nullptr) {}
    virtual ~UserTerminal();

  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual cModule* findClosestSatellite();
    virtual double calculateDistance(cModule *satellite);
    virtual void sendPingToClosestSatellite();
    virtual void updateRoutingTable(cModule *closestSatellite);
};

Define_Module(UserTerminal);

UserTerminal::~UserTerminal() {
    cancelAndDelete(pingTimer);
}

void UserTerminal::initialize() {
    // Read parameters from NED file
    antennaRange = par("antennaRange").doubleValue();

    // Initialize the wireless interface(s) for the UserTerminal
    int numWlanInterfaces = par("numWlanInterfaces").intValue(); // Default value in NED is 1
    for (int i = 0; i < numWlanInterfaces; i++) {
        cModule *wlanModule = getParentModule()->getSubmodule("wlan", i);
        if (!wlanModule) {
            throw cRuntimeError("UserTerminal: wlan[%d] interface not found", i);
        }
        wlanModule->par("typename") = "Ieee80211Interface"; // Assign interface type
    }

    // Initialize the ping timer
    pingTimer = new cMessage("PingTimer");
    scheduleAt(simTime() + 1.0, pingTimer);
}

void UserTerminal::handleMessage(cMessage *msg) {
    if (msg == pingTimer) {
        EV << "UserTerminal " << getName() << " is searching for the closest satellite.\n";
        closestSatellite = findClosestSatellite();
        if (closestSatellite) {
            EV << "Closest satellite to UserTerminal " << getName() << " is: "
               << closestSatellite->getFullName()
               << " (Distance: " << calculateDistance(closestSatellite) << " m)\n";
            sendPingToClosestSatellite();
            updateRoutingTable(closestSatellite);
        } else {
            EV << "No satellite within range of UserTerminal " << getName() << "\n";
        }
        scheduleAt(simTime() + 1.0, pingTimer);
    }
}

cModule* UserTerminal::findClosestSatellite() {
    double minDistance = antennaRange;
    cModule *closest = nullptr;

    cModule *network = getModuleByPath("^.^"); // Find the parent network
    for (cModule::SubmoduleIterator it(network); !it.end(); ++it) {
        cModule *satellite = *it;
        if (std::string(satellite->getModuleType()->getName()) == "SatelliteNode") {
            double distance = calculateDistance(satellite);
            if (distance <= minDistance) {
                minDistance = distance;
                closest = satellite;
            }
        }
    }
    return closest;
}

double UserTerminal::calculateDistance(cModule *satellite) {
    double x1 = par("x").doubleValue();
    double y1 = par("y").doubleValue();
    double z1 = par("z").doubleValue();
    double x2 = satellite->par("x").doubleValue();
    double y2 = satellite->par("y").doubleValue();
    double z2 = satellite->par("z").doubleValue();
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2) + pow(z2 - z1, 2));
}

void UserTerminal::sendPingToClosestSatellite() {
    EV << "UserTerminal " << getName() << " sending ping to Satellite " << closestSatellite->getName() << "\n";
    cPacket *ping = new cPacket("PingPacket");
    sendDirect(ping, closestSatellite, "in");
}

void UserTerminal::updateRoutingTable(cModule *closestSatellite) {
    if (!closestSatellite) return;

    // Access the routing table
    IRoutingTable *routingTable = check_and_cast<IRoutingTable *>(getModuleByPath("^.routingTable"));
    if (!routingTable) {
        EV << "Routing table not found for UserTerminal " << getName() << "\n";
        return;
    }

    std::string satelliteAddress = closestSatellite->par("ipAddress").stringValue();

    // Clear outdated routes
    for (int i = routingTable->getNumRoutes() - 1; i >= 0; --i) {
        Ipv4Route *route = routingTable->getRoute(i);
        if (route->getGateway().str() != satelliteAddress) {
            routingTable->deleteRoute(route);
        }
    }

    // Add new route
    Ipv4Route *route = new Ipv4Route();
    route->setDestination(Ipv4Address(satelliteAddress.c_str()));
    route->setNetmask(Ipv4Address::ALLONES_ADDRESS);
    route->setGateway(Ipv4Address(satelliteAddress.c_str()));
    route->setInterface(routingTable->getInterfaceByName("wlan0"));
    routingTable->addRoute(route);

    EV << "Routing table updated: Destination = " << satelliteAddress << "\n";
}
