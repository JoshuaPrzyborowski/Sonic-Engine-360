/// Spring Collision Checks

/*
 Handles springs of any angle, you just need to set the correct variables in the spring creation event and 
 you need to make sure the origin of the spring is correct (look at the other spring sprites to copy)
*/

var hspd_set, vspd_set, spd_set, spd_factor, dir_check, pos_check;

with (Player)   // Note with all items, the code is used in the item but it runs through inside the Player
{
    if (action == act_death || point_distance(x, y, other.x, other.y) > 100) continue;  // Don't run through code if Player is dead or too far away

    // Set solid if the Player's direction isn't going into the Spring or the Player's position is the wrong side of the Spring (set non-solid otherwise)
    dir_check = (abs(((((other.angle - radtodeg(full_direction)) mod 360) + 540) mod 360) - 180) < 90) && !(full_hspeed == 0 && full_vspeed == 0);
    pos_check = abs(((((other.angle - radtodeg(arctan2(other.yorig - (y - mask_radius*other.dsin_val), (x - mask_radius*other.dcos_val) - other.xorig))) mod 360) + 540) mod 360) - 180) >= 90;
    other.solid = (dir_check || pos_check);

    // Only execute hit action if non-solid and a collision is going to occur
    if (other.solid == false && collision_onset(other.id) && other.action == 0)
    {
        other.action = 1;       // Set the spring action to 1, to show it's being sprung
        other.alarm[0] = 18;    // Time for the spring to reset back to normal after being triggered

        // Get the hspeed and vspeed which the player will be set to (note this is dependent on the original player's speed)
        hspd_set = (abs(full_hspeed*other.bounce_factor) + other.strength)*other.dcos_val + (abs(full_vspeed)*other.dcos_val + full_hspeed*abs(other.dsin_val))*abs(other.dsin_val);
        vspd_set = (abs(full_vspeed*other.bounce_factor) + other.strength)*other.dsin_val + (abs(full_hspeed)*other.dsin_val - full_vspeed*abs(other.dcos_val))*abs(other.dsin_val);

        // Limit the speed allowed from the spring
        spd_set = sqrt(hspd_set*hspd_set + vspd_set*vspd_set);
        spd_factor = other.max_speed/spd_set;

        if (spd_factor < 1)
        {
            hspd_set *= spd_factor;
            vspd_set *= spd_factor;
        }

        // Now spring the player
        hsp = hspd_set;
        vsp = vspd_set;

        if (other.angle > 25 && other.angle < 155)    // Only if the angle of the Spring is pointing upwards does it set the Player to the spring sprite action
        {
            ground = 0;                 // Set Player off the ground
            angle = 0;
            dcos_val = 1;
            dsin_val = 0;
            action = act_spring;        // Set the player action to springing
        }
        sound_play(SndSpring);
    }
}

/* */
/*  */
