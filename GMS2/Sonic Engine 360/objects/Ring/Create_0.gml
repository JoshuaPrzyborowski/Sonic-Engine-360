//==============================================================================
    animation           = -1;
    animations_old      = -1;
    animations_frame    = 0;
    animations_framemin = 0;
    animations_framemax = 0;
    animations_speed    = 0;
    animations_timer    = 0;
    animations_return   = 0;

    ani_framemin[0]     = 0;
    ani_framemax[0]     = 7;
    ani_return[0]       = 0;
    ani_speed[0]        = 30;

    ani_framemin[1]     = 8;
    ani_framemax[1]     = 8;
    ani_return[1]       = 8;
    ani_speed[1]        = 0;

//==============================================================================
    action     = 0;   // Action start at 0 to shown it's not been collected
    ring_loss  = 0;   // Whether the ring has been lost
    invisible  = 0;   // Insible set to 0 (visibility is flashed when ring loss is true)
    attracted  = 0;   // For electricity shiedl attraction

