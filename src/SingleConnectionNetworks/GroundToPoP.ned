package leosatelliteenvironment.SingleConnectionNetworks;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth100G;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;

import leosatelliteenvironment.Modules.*;

network GroundToPoP {
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            parameters:
                @display("p=100,300;is=s");
        }
        
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=50,200");
        }
        
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
        
        pop: PoP {
            parameters:
                @display("p=205,69");
        }
        
        groundStation: GroundStation {
            parameters:
                @display("p=296,69");
        }
    
    connections:
    	groundStation.ethg++ <--> Eth100G <--> pop.ethg++;

}