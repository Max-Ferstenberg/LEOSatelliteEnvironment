package leosatelliteenvironment.Modules;

import inet.node.inet.AdhocHost;
import inet.mobility.contract.IMobility;
import inet.physicallayer.wireless.common.medium.MediumLimitCache;

module Satellite extends AdhocHost {
    parameters:
        numWlanInterfaces = 1;
        wlan[0].typename = "Ieee80211Interface"; // Add IEEE 802.11 wireless support
        @display("i=device/satellite");
        @statistic[coordX](title="coord X"; source="xCoord(mobilityPos(mobilityStateChanged))"; record=vector; interpolationmode=linear);
        @statistic[coordY](title="coord Y"; source="yCoord(mobilityPos(mobilityStateChanged))"; record=vector; interpolationmode=linear);
        @statistic[coordZ](title="coord Z"; source="zCoord(mobilityPos(mobilityStateChanged))"; record=vector; interpolationmode=linear);
        
        mobility.typename = default("CircleMobility");
        @class(SatelliteNode);
}
