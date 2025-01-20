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
            @display("p=64,43;is=s");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=64,105;is=s");
        }
        visualizer: IntegratedVisualizer {
            @display("p=64,163;is=s");
        }
        userTerminal: UserTerminal {
            @display("p=300, 200;i=device/laptop");
        }
        satellite1: Satellite {
            @display("p=450, 300;i=device/satellite");
        }
        satellite2: Satellite {
            @display("p=750, 300;i=device/satellite");
        }
        groundStation: GroundStation {
            @display("p=300,400;i=device/router");
        }
        pop: PoP {
            @display("p=50, 400;i=device/server");
        }
    connections allowunconnected:
}
