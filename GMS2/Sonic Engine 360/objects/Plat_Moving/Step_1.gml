with (Player)       // Note with all items, the code is used in the items but it runs through inside the Player
{
    other.solid = (y + mask_radius <= other.y - other.offset && full_vspeed >= 0);  //makes it a jump-through platform

    // Move the Player position by the platform hspeed/vspeed values so the Player moves the same amount as the platform
    if (ground && other.solid && place_meeting(x, y + 1, other))
    {
        x += other.hsp;
        y += other.vsp;
    }
}

// Direction changing code (not when time_change is set to -1 no change occurs)
if (time_change != -1)
{
    if (time >= time_change)    // Check if it's time to change the platform momentum
    {
        switch (change_type)    // Switch so you can have different actions occurring
        {
            case 0:             // Standard change type - just reverses the platform speed
                hsp *= -1;
                vsp *= -1;
            break;
        }
        time = 0;  // Reset the time
    }
    time += 1;  // Increase the time every step
}

// Move the platform depending on it's hspeed and vspeed
x += hsp;
y += vsp;

