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
    ani_framemax[0]     = 0;
    ani_return[0]       = 0;
    ani_speed[0]        = 0;

    ani_framemin[1]     = 1;
    ani_framemax[1]     = 2;
    ani_return[1]       = 2;
    ani_speed[1]        = 25;

//==============================================================================
    action  = 0;                       // Start action (not springing)
    dcos_val    = cos(degtorad(angle));    // Cos compenent given the angle of the spring
    dsin_val    = -sin(degtorad(angle));   // Sin compenent given the angle of the spring
    xorig   = x + dcos_val*offset;         // Get the origin x point of the spring area line
    yorig   = y + dsin_val*offset;         // Get the origin y point of the spring area line

