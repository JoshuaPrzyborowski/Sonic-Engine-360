/// Spike collision checks

with (Player)       // Note with all items, the code is used in the items but it runs through inside the Player
{
    if (action == act_death || point_distance(x, y, other.x, other.y) > 100) continue;  // Don't run through code if Player is dead or too far away

    // Set solid if Player is invincible, moving upwards or not above the spike (set non-solid otherwise)
    other.solid = (invincibility != -1 || full_vspeed < 0 || y + mask_radius > other.y - other.offset);

    // Only execute hit action if non-solid (the conditions for this are set at the bottom of the code) and a collision is going to occur
    if (other.solid == false && collision_onset(other.id))
    {
        player_hurt();
    }
}

