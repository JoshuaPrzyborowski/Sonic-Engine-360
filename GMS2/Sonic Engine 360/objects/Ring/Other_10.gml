/// Ring Loss Initialization

    // Decay variables
    decay_count         = 0;    // Start the decay
    decay_life          = 270;  // Time till it's destroyed

    // Set the speed and direction of the rings so they are moving directly away from the Player position
    dir                 = arctan2(Player.y-y, x-Player.x);
    spd                 = 6.4;
    hsp                 = spd*cos(dir) + random(2) - random(2);
    vsp                 = spd*-sin(dir);

    // Move the rings outside of any objects (to make sure they are not created inside walls)
    var i;
    i = 200;
    while (place_meeting(x,y, WallParent) && i > 0)
    {
        x += hsp;
        y += vsp;
        i -= 1;
    }

    // Set ring_loss variable to true so it knows it's of the ring_loss type
    ring_loss = 1;

