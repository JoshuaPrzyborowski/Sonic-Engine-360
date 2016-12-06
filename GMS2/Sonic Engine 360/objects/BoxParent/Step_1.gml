/// Box collision checks

var vspd_set;

with (Player)       // Note with all items, the code is used in the items but it runs through inside the Player
{
    if (action == act_death || point_distance(x, y, other.x, other.y) > 100) continue;  // Don't run through code if Player is dead or too far away

    // Set solid if Player isn't rolling and the box isn't destroyed (set non-solid otherwise)
    other.solid = (action != act_roll && other.action == 0);

    // Only execute hit action if non-solid and a collision is going to occur
    if (other.solid == false && collision_onset(other.id) && other.action == 0)
    {
        if (full_vspeed > 0)   // If the Player is moving downwards then going to bounce off the box
        {
            vspd_set = full_vspeed*-other.bounce_factor;    // Get the vspeed to bounce up at (note this is dependent on the Player's original vspeed)
            vsp = vspd_set;                                 // Now set the Player vspeed to this value
        }
        other.action = 1;                     // Set the box action to 1 to show it has been destroyed
        player_box_action(other.box_type);    // Script to make the box powerup action occur   
    }
}

