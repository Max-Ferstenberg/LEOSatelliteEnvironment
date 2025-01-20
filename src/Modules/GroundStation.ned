package leosatelliteenvironment.Modules;

import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.node.inet.Router;
import inet.node.inet.AdhocHost;

module GroundStation extends AdhocHost {
    parameters:
        numWlanInterfaces = 1; // Two wlan interfaces
        // Wireless interface
        wlan[0].typename = "Ieee80211Interface"; 

        wlan[1].typename = "EthernetInterface"; // Simulates a wired connection
        @display("i=device/router"); // Display icon
        @class(GroundStation);
}
