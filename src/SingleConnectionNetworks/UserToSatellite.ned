package leosatelliteenvironment.SingleConnectionNetworks;

import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.common.IntegratedVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

import leosatelliteenvironment.Modules.*;

network UserToSatellite
{
    @display("bgb=700,400");
    @statistic[receptionPower](source="receptionMinSignalPower(radioMedium.signalArrivalStarted)"; record=vector);

    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=62,43;is=s");
        }
        visualizer: IntegratedVisualizer {
            @display("p=62,121;is=s");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=62,199;is=s");
        }
        userTerminal: UserTerminal {
            @display("p=340,248");
        }
        satellite: Satellite {
            @display("p=460,248");
        }


    connections allowunconnected: // Wireless communication doesn’t require explicit connections
}
