// -> Note some local variables must be set in the instance creation code or here just in the creation if used! The variables required are as follows:
//
//  time_change - number of steps till the direction changes [-1 = no change happens]
//  change_type - type of change that occurs [0 = reverse speed]
//  hsp         - hspeed of the platform
//  vsp         - vspeed of the platform
//
//==============================================================================

    time    = 0;   //timing used to know when to change direction
    offset = 15;   // Offset from the sprite origin to use for the collision line (the lower the value the larger the action area will be)

