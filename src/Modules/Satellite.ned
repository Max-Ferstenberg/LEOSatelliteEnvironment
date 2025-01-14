package leosatelliteenvironment.Modules;

import inet.node.inet.AdhocHost;

module Satellite extends AdhocHost {
    parameters:
        numWlanInterfaces = 2;
        wlan[0].typename = "Ieee80211Interface"; // Add IEEE 802.11 wireless support
        wlan[0].radio.transmitter.power = 100mW; // Set transmission power
        wlan[0].radio.receiver.sensitivity = -90dBm; // Set receiver sensitivity
        @display("i=device/satellite");
}
