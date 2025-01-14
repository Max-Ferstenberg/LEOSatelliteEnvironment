package leosatelliteenvironment.Modules;

import inet.node.inet.AdhocHost;
import inet.physicallayer.wireless.common.antenna.ParabolicAntenna;

module UserTerminal extends AdhocHost {
    parameters:
        numWlanInterfaces = 1;
        wlan[0].typename = "Ieee80211Interface"; // Add IEEE 802.11 wireless support
        wlan[0].radio.antenna.typename = "ParabolicAntenna"; // Use parabolic antenna
        wlan[0].radio.transmitter.power = 50mW; // Set transmission power
        wlan[0].radio.receiver.sensitivity = -85dBm; // Set receiver sensitivity
        @display("i=device/laptop");
}
