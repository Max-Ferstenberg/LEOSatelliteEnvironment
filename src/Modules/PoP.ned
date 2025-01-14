package leosatelliteenvironment.Modules;

import inet.node.inet.StandardHost;

module PoP extends StandardHost
{
	parameters:
        eth[0].typename = "EthernetInterface"; // Ethernet interface
        @display("i=device/router"); 
}