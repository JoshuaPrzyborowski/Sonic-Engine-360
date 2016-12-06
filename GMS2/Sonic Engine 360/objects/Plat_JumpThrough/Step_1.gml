with (Player)       // Note with all items, the code is used in the items but it runs through inside the Player
{
    // Only set the solid collision to happen if the Player is above the platform and not moving upwards
    other.solid = (y + mask_radius <= other.y - other.offset && full_vspeed >= 0);
}

