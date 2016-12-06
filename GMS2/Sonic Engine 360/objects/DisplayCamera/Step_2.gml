/// Display camera movement (note the view_object is set to this display camera in the Player creation code)

with (Player)
{
    if (action == act_death)  // Death code handled in first code piece, but still need to exit this step code when dead
        return 0;

    if (action == act_lookdown && camera.ypan >= 0)
        camera.ypan += 4;           // Pan the camera downwards (note the camera pan naturally moves 2 towards the center every step)

    if (action == act_lookup && camera.ypan <= 0)
        camera.ypan -= 4;           // Pan the camera upwards (note the camera pan naturally moves 2 towards the center every step)

    // Set camera to Player position plus the camera pan (with a leniency of 60 before panning)
    camera.x = x + max(0, abs(camera.xpan) - 60) * sign(camera.xpan);       
    camera.y = y + max(0, abs(camera.ypan) - 60) * sign(camera.ypan);

    // Move the camera pans toward the center each step if they are set
    if (abs(camera.xpan) > 0)
        camera.xpan = max(0, min(abs(camera.xpan) - 2, floor(__view_get( e__VW.XView, 0 )/2))) * sign(camera.xpan);
    if (abs(camera.ypan) > 0)
        camera.ypan = max(0, min(abs(camera.ypan) - 2, floor(__view_get( e__VW.HView, 0 )/2))) * sign(camera.ypan);
}

