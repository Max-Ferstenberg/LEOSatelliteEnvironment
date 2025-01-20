#ifndef SATELLITENODE_H
#define SATELLITENODE_H

#include <omnetpp.h>
#include <map>
#include <string>

namespace leosatelliteenvironment {

using namespace omnetpp;

class SatelliteNode : public cSimpleModule {
  private:
    cMessage *moveTimer;
    cMessage *pingTimer;
    int stepCount;

    std::map<int, double> neighbors;
    std::map<int, double> routingTable;

  public:
    SatelliteNode();
    virtual ~SatelliteNode();

  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void moveSatellite();
    virtual void sendPing();
    void updateLISLs();
    void calculateShortestPaths(int sourceId);
    cModule* findNextHop(const std::string &destinationAddress);
};

} // namespace leosatelliteenvironment

#endif // SATELLITENODE_H
