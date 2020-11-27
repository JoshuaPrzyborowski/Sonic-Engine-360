/// Ring collision checks

with (Player)       // Note with all items, the code is used in the items but it runs through inside the Player
{
    if (action == act_hit || action == act_death || (!other.attracted && point_distance(x, y, other.x, other.y) > 100)) continue;  // Don't run through code if Player is hit, dead or too far away

    // Move towards Player with elecricity shield
    if (shield == 3)
    {
        other.attracted = 1;
    }

    if (other.attracted)
    {
        if (shield != 3)
        {
            other.attracted = 0;
        }
        else
        {
            with (other)
            {
                move_towards_point(other.x, other.y, 4.5 + point_distance(x, y, other.x, other.y)/15);
            }
        }
    }    

    // Only execute collect action if a collision is going to occur
    if (other.action == 0 && collision_onset(other.id))
    {
        other.action = 1;
        other.alarm[0] = 8;   // Set the alarm to destroy the ring

        player_ring(1);       // Add 1 ring to the Player
    }
}

/// Ring Loss Step

if (ring_loss)
{  
    // Set friction to the moving ring speed
    if (hsp > 0)
    {
        hsp -= 0.025;
        if (hsp < 0) hsp = 0;
    }
    if (hsp < 0)
    {
        hsp += 0.025;
        if (hsp > 0) hsp = 0;
    }

    // Add gravity to the ring
    vsp += 0.2;

    // Bounce off of wall when collising with them 
    // -> Note if you used the local hspeed/vspeed variables for the ring you could then use the build-in move_bounce_solid function instead if you wanted
    if (place_meeting(x+hsp, y+vsp, WallParent))
    {
        if (place_meeting(x + hsp, y, WallParent))
            hsp *= -0.65;
        if (place_meeting(x, y + vsp, WallParent))
            vsp *= -0.65;
    }

    // Move the ring based on it's hspeed and vspeed
    x += hsp; y += vsp;
}

