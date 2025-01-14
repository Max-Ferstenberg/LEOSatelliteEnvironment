package leosatelliteenvironment.SingleConnectionNetworks;

import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.common.IntegratedVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.StandardHost;

import leosatelliteenvironment.Modules.*;

network SatelliteToGround
{
    @display("bgb=700,400");
    @statistic[receptionPower](source="receptionMinSignalPower(radioMedium.signalArrivalStarted)"; record=vector);
    
    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,50");
        }
        visualizer: IntegratedVisualizer {
            @display("p=50,150");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=50,250");
        }
        groundStation: GroundStation {
            parameters:
                @display("r=,,#707070;p=150,300");
        }
        satellite: Satellite {
            parameters:
                @display("r=,,#707070;p=450,300");
        }
        
        connections allowunconnected:
}
