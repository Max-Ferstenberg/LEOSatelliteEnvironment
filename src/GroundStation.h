#ifndef GROUNDSTATION_H
#define GROUNDSTATION_H

#include <omnetpp.h>
#include "inet/networklayer/contract/IRoutingTable.h"
#include "inet/networklayer/ipv4/Ipv4Route.h"

namespace leosatelliteenvironment {

using namespace omnetpp;
using namespace inet;

class GroundStation : public cSimpleModule {
  private:
    cMessage *pingTimer;       // Timer for periodic pings
    double antennaRange;       // Antenna range
    cModule *closestSatellite; // Closest satellite in range

  public:
    GroundStation();
    virtual ~GroundStation();

  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual cModule* findClosestSatellite();
    virtual double calculateDistance(cModule *satellite);
    virtual void sendPingToClosestSatellite();
    virtual void updateRoutingTable(cModule *closestSatellite);
};

} // namespace leosatelliteenvironment

#endif // GROUNDSTATION_H
