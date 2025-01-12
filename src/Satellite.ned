package leosatelliteenvironment;

import inet.node.inet.AdhocHost;
import inet.physicallayer.wireless.common.antenna.ParabolicAntenna;

module Satellite extends AdhocHost {
    parameters:
        numWlanInterfaces = 1;
        wlan[0].typename = "Ieee80211Interface"; // Add IEEE 802.11 wireless support
        wlan[0].radio.antenna.typename = "ParabolicAntenna"; // Use parabolic antenna
        wlan[0].radio.transmitter.power = 100mW; // Set transmission power
        wlan[0].radio.receiver.sensitivity = -90dBm; // Set receiver sensitivity
        @display("i=device/satellite");

    submodules:
        // Antenna configuration for wlan[0]
        antenna: ParabolicAntenna {
            @display("i=device/antenna");
            maxGain = 12dB;
            minGain = -25dB; 
            beamWidth = 40deg;
        }
}
