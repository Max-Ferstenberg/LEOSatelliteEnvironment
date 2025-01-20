#ifndef USERTERMINAL_H
#define USERTERMINAL_H

#include <omnetpp.h>
#include "inet/networklayer/contract/IRoutingTable.h"
#include "inet/networklayer/ipv4/Ipv4Route.h"

namespace leosatelliteenvironment {

using namespace omnetpp;
using namespace inet;

class UserTerminal : public cSimpleModule {
  private:
    cMessage *pingTimer;       // Timer for periodic pings
    double antennaRange;       // Antenna range
    cModule *closestSatellite; // Closest satellite in range

  public:
    UserTerminal();
    virtual ~UserTerminal();

  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual cModule* findClosestSatellite();
    virtual double calculateDistance(cModule *satellite);
    virtual void sendPingToClosestSatellite();
    virtual void updateRoutingTable(cModule *closestSatellite);
};

} // namespace leosatelliteenvironment

#endif // USERTERMINAL_H
