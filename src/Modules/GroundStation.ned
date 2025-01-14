package leosatelliteenvironment.Modules;

import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.node.inet.Router;
import inet.node.inet.AdhocHost;

module GroundStation extends AdhocHost {
    parameters:
        numWlanInterfaces = 1; // Two wlan interfaces
        // Wireless interface
        wlan[0].typename = "Ieee80211Interface"; 
        wlan[0].radio.antenna.typename = "ParabolicAntenna";
        wlan[0].radio.transmitter.power = 100mW; // Set transmission power
        wlan[0].radio.receiver.sensitivity = -90dBm; // Set receiver sensitivity

        eth[0].typename = "EthernetInterface"; // Simulates a wired connection
        @display("i=device/router"); // Display icon
}
