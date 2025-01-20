package leosatelliteenvironment;

import inet.physicallayer.wireless.common.antenna.IsotropicAntenna;

simple SatelliteNode {
    parameters:
        @display("i=device/satellite");
        double antennaRange @unit(m) = 1000m; // Antenna range for inter-satellite links
        double mobilitySpeed @unit(mps) = 1mps; // Speed of satellite movement
        string ipAddress;                      // IP Address of the satellite
        double x @unit(m);                     // X-coordinate
        double y @unit(m);                     // Y-coordinate
        double z @unit(m);                     // Z-coordinate

        int numWlanInterfaces = 1;              // Number of wireless interfaces
        wlan[0].typename = "Ieee80211Interface"; // Add IEEE 802.11 wireless support
    gates:
        input in[];
        output out[];
}