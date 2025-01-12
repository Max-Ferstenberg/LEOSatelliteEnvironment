package leosatelliteenvironment;

import leosatelliteenvironment.UserTerminal;
import leosatelliteenvironment.Satellite;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.common.RadioVisualizer;
import inet.visualizer.canvas.physicallayer.RadioCanvasVisualizer;

network RadioCommunication
{
    submodules:
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=35,32;is=s");
        }
        userTerminal: UserTerminal {
            parameters:
                @display("p=100,300;i=device/laptop");
        }
        satellite: Satellite {
            parameters:
                @display("p=300,100;i=device/satellite");
        }
        visualizer: RadioVisualizer {
            parameters:
                @display("p=200,200"); // Positioning of the visualizer module in the display
        }
        canvasVisualizer: RadioCanvasVisualizer {
            parameters:
                zIndex = 10; // Optional: setting zIndex if necessary
                @display("p=100,100"); // Positioning the canvas visualizer
        }

    connections allowunconnected: // Wireless communication doesn’t require explicit connections
}


