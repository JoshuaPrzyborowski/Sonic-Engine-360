// standard action to hurt the player

if (shield != 0)
{
    shield = 0;                 // Turn off shield
}
else
{
    if (rings == 0)  // Death action if no rings
    {
        action = act_death;     // Set the player action to dead
        vsp = -7;               // Set the Player vspeed so it goes up (the Player then falls down in the step event with set gravity
        life -= 1;              // Set Life minus 1
        sound_stop_all();
        sound_play(SndDie);
        return false;
    }
    else
    {
        player_lose_rings();    // Call script to lose the rings
    }
}

/* Hit action if not died */

action = act_hit;           // Set the player action to hit
invincibility = inv_hit;    // Start the invicibility hit counter for the Player being hit
ground = 0;                 // Set the Player off ground
angle = 0;
dcos_val = 1;
dsin_val = 0;
sound_play(SndDie);

// Set the speed of the Player so it creates a standard arc for the hit Player to move by
hsp = lengthdir_x(6.1, 90 + 28*xdir);
vsp = lengthdir_y(6.1, 90 + 28*xdir);
