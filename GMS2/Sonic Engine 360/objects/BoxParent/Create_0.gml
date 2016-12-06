//==============================================================================
    action              = 0;                    // Start action not destroyed
    bounce_factor       = 0.65;                 // Factor of player speed to add to momentum
    flash_count         = 0;                    // Counter for flashing the icon
    explosion_count     = 0;                    // Counter used for the explosion
    icon_speed          = 2.3;                  // Speed of the icon going up
    icon_y              = -6;                   // Position of the icon

    box_type            = floor(random(9));     // Type of box it is, you can make new child objects to set this or set it in the room creation code

    //Box Types
    /*
        0 - Life
        1 - Eggman
        2 - Ring
        3 - Shield Basic
        4 - Shield Fire
        5 - Shield Electricity
        6 - Shield Water
        7 - Invincibility
        8 - Sneekers
    */

/* */
/*  */
