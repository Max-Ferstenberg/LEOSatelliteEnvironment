package leosatelliteenvironment;

import inet.physicallayer.wireless.common.antenna.ParabolicAntenna;

simple UserTerminal {
    parameters:
        @display("i=device/laptop");
        double antennaRange @unit(m) = 500m; // Antenna range
        string ipAddress;                  // IP Address
        double x @unit(m);                 // X-coordinate
        double y @unit(m);                 // Y-coordinate
        double z @unit(m);                 // Z-coordinate

        wlan[0].typename = "Ieee80211Interface"; 
    gates:
        input in;
        output out;
}