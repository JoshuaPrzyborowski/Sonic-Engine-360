// I advise using integer values for the speeds otherwise you will have to set-up a system to account for the coordinate rounding 
// As this would cause the platform to be drawn at different positions relative to sonic when moving which will make it look jumpy

hsp = 1;
vsp = 0;

time_change = 352/hsp;  // Note: this can be used to set the distance moved to 352 pixels
change_type = 0;        // Reverse direction when time change occurs
