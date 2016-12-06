
    // Loses the player rings
    var i, theta, error, inner_circ, inner_radius, outer_circ, outer_radius;

    theta = (pi/16);              // Half the angle in radians between rings 
    error = 0.0001;               // Addition due to error in rounding
    if (rings <= 16)
    {
        inner_circ = rings;       // Number of rings in inner circle
    }
    else
    {
        inner_circ = 16;
        if (rings <= 32)
        {
            outer_circ = rings - 16;     // Number of rings in outer circle
        }
        else
        {
            outer_circ = 16;
        }

        outer_radius = 35;               // Radius of the outer ring circle

        // Create the outer instances of the ring losses
        for (i = -theta*(outer_circ-1); i <= theta*(outer_circ-1)+error; i += 2*theta)
        {
            with (instance_create(x + cos(i-pi/2)*outer_radius, y + sin(i-pi/2)*outer_radius, Ring))
                event_user(0);   // Calls special code when ring is of ring_loss type
        }
    }

    inner_radius = 5;                   // Radius of the inner ring circle

    // Create the inner instances of the ring losses
    for (i = -theta*(inner_circ-1); i <= theta*(inner_circ-1)+error; i += 2*theta)
    {
        with (instance_create(x + cos(i-pi/2)*inner_radius, y + sin(i-pi/2)*inner_radius, Ring))
            event_user(0);   // Calls special code when ring is of ring_loss type
    }

    rings = 0;
    sound_play(SndRingLoss);
