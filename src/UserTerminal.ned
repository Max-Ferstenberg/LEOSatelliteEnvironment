package leosatelliteenvironment;

import inet.node.inet.WirelessHost;
import inet.physicallayer.wireless.common.antenna.ParabolicAntenna;

module UserTerminal extends WirelessHost {
    parameters:
        numWlanInterfaces = 1;
        wlan[0].typename = "Ieee80211Interface"; // Add IEEE 802.11 wireless support
        wlan[0].radio.antenna.typename = "ParabolicAntenna"; // Use parabolic antenna
        wlan[0].radio.transmitter.power = 50mW; // Set transmission power
        wlan[0].radio.receiver.sensitivity = -85dBm; // Set receiver sensitivity
        @display("i=device/laptop");

    submodules:
        // Antenna configuration for wlan[0]
        antenna: ParabolicAntenna {
            @display("i=device/antenna");
            maxGain = 10dB;  // Maximum gain (example, adjust as needed)
            minGain = -20dB; // Minimum gain (example, adjust as needed)
            beamWidth = 30deg; // Beam width (example, adjust as needed)
        }
}
