#include <omnetpp.h>
#include <vector>
#include <map>
#include <queue>
#include <limits>
#include "SatelliteNode.h"

using namespace omnetpp;

class SatelliteNode : public cSimpleModule {
  private:
    cMessage *moveTimer;    // Timer for movement
    cMessage *pingTimer;    // Timer for pings
    int stepCount = 0;      // Track movement steps

    // LISL Management
    std::map<int, double> neighbors; // Map of neighboring satellite IDs and their distances
    std::map<int, double> routingTable; // Map of satellite IDs and their shortest path costs

  public:
    SatelliteNode() : moveTimer(nullptr), pingTimer(nullptr) {}
    virtual ~SatelliteNode();

  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void moveSatellite();
    virtual void sendPing();

    // LISL Management and Shortest Path
    void updateLISLs();
    void calculateShortestPaths(int sourceId);
    cModule* findNextHop(const std::string &destinationAddress);
};

Define_Module(SatelliteNode);
Register_Class(SatelliteNode);

SatelliteNode::~SatelliteNode() {
    cancelAndDelete(moveTimer);
    cancelAndDelete(pingTimer);
}

void SatelliteNode::initialize() {
    moveTimer = new cMessage("MoveTimer");
    pingTimer = new cMessage("PingTimer");

    // Schedule the first movement
    scheduleAt(simTime() + 1.0, moveTimer);

    // Initialize LISL neighbors (example setup, replace with dynamic logic if needed)
    neighbors = {{1, 300.0}, {2, 500.0}, {3, 700.0}}; // Example: Neighbor ID and distance

    // Initialize routing table (infinity for all satellites initially)
    for (const auto& neighbor : neighbors) {
        routingTable[neighbor.first] = std::numeric_limits<double>::infinity();
    }
}

void SatelliteNode::handleMessage(cMessage *msg) {
    if (msg == moveTimer) {
        moveSatellite();
        updateLISLs();
        calculateShortestPaths(getId());

        scheduleAt(simTime() + 1.0, pingTimer);
    } else if (msg == pingTimer) {
        sendPing();

        scheduleAt(simTime() + 1.0, moveTimer);
    }

    if (dynamic_cast<cPacket *>(msg)) {
        cPacket *packet = check_and_cast<cPacket *>(msg);
        EV << "Satellite " << getName() << " received packet: "
           << packet->getName()
           << " from: " << packet->getSenderModule()->getFullName() << "\n";

        cModule *nextHop = findNextHop(packet->par("destinationAddress").stringValue());
        if (nextHop) {
            EV << "Routing packet: " << packet->getName()
               << " to next hop: " << nextHop->getFullName() << "\n";
            sendDirect(packet, nextHop, "in");
        } else {
            EV << "No route found for packet: " << packet->getName()
               << ". Sending ICMP Destination Unreachable.\n";
            delete packet;
        }
    } else {
        EV << "Satellite " << getName() << " received non-packet message: " << msg->getName() << "\n";
        delete msg;
    }
}

void SatelliteNode::moveSatellite() {
    EV << "Satellite " << getName() << " is moving. Step count: " << stepCount << "\n";
    stepCount++;

    // Simulate new position
    double newX = uniform(0, 1000);
    double newY = uniform(0, 1000);
    double newZ = uniform(0, 1000);

    EV << "New position: (" << newX << ", " << newY << ", " << newZ << ")\n";
}

void SatelliteNode::sendPing() {
    EV << "Satellite " << getName() << " is sending network pings.\n";

    cPacket *ping = new cPacket("PingPacket");
    send(ping, "out");
}

void SatelliteNode::updateLISLs() {
    EV << "Updating LISLs for Satellite " << getName() << "\n";

    // Example: Dynamically update distances to neighbors (replace with actual logic)
    for (auto& neighbor : neighbors) {
        neighbor.second = uniform(100, 1000); // Randomize distances to simulate movement
        EV << "Neighbor " << neighbor.first << " distance: " << neighbor.second << "\n";
    }
}

void SatelliteNode::calculateShortestPaths(int sourceId) {
    EV << "Calculating shortest paths from Satellite " << getName() << " (ID: " << sourceId << ")\n";

    // Priority queue for Dijkstra's algorithm
    std::priority_queue<std::pair<double, int>, std::vector<std::pair<double, int>>, std::greater<>> pq;

    // Initialize distances
    std::map<int, double> distances;
    for (const auto& neighbor : neighbors) {
        distances[neighbor.first] = std::numeric_limits<double>::infinity();
    }
    distances[sourceId] = 0;

    // Push source to priority queue
    pq.push({0.0, sourceId});

    while (!pq.empty()) {
        auto [currentDistance, currentNode] = pq.top();
        pq.pop();

        if (currentDistance > distances[currentNode]) {
            continue;
        }

        // Update distances for neighbors
        for (const auto& neighbor : neighbors) {
            int neighborId = neighbor.first;
            double weight = neighbor.second;

            double newDistance = currentDistance + weight;
            if (newDistance < distances[neighborId]) {
                distances[neighborId] = newDistance;
                pq.push({newDistance, neighborId});
            }
        }
    }

    // Update routing table with calculated shortest paths
    routingTable = distances;

    // Log the routing table
    for (const auto& route : routingTable) {
        EV << "Shortest path to Satellite " << route.first << " is " << route.second << "\n";
    }
}

cModule* SatelliteNode::findNextHop(const std::string &destinationAddress) {
    EV << "Satellite " << getName() << " is determining the next hop for destination: "
       << destinationAddress << "\n";

    // Placeholder for routing logic
    // Implement lookup or logic to return the next hop module here
    return nullptr;
}
