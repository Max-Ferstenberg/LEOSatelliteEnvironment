package leosatelliteenvironment;

import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.node.inet.StandardHost;
import inet.visualizer.common.IntegratedVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

import leosatelliteenvironment.Modules.*;

network SatelliteNetwork
{
    parameters:
        @display("bgb=1000,600");
    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=62,43;is=s");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=500,50;is=s");
        }
        visualizer: IntegratedVisualizer {
            @display("p=500,550;is=s");
        }
        userTerminal: UserTerminal {
            @display("p=265,300;i=device/laptop");
        }
        satellite: Satellite {
            @display("p=500,300;i=device/satellite");
        }
        groundStation: GroundStation {
            @display("p=753,300;i=device/router");
        }
    connections allowunconnected:
}
