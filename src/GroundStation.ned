package leosatelliteenvironment;

import inet.physicallayer.wireless.common.antenna.ParabolicAntenna;

simple GroundStation {
    parameters:
        @display("i=device/router");
        double antennaRange @unit(m) = 800m; // Antenna range
        int numWlanInterfaces = 2;          // Number of wireless interfaces
        string ipAddress;                   // IP Address
        double x @unit(m);                  // X-coordinate
        double y @unit(m);                  // Y-coordinate
        double z @unit(m);                  // Z-coordinate

        wlan[0].typename = "Ieee80211Interface"; // Wireless interface
        wlan[1].typename = "EthernetInterface";  // Wired connection
    gates:
        input in[];
        output out[];
}
