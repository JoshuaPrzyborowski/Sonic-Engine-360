// Checks if there is going to be a collision with the object giving in argument0 given the Player's current speed
// To be accurate it does this using a place_meeting check at the position the Player will be at given it's hspeed / vspeed
// And also using two collision lines either side of the player mask from the Player's current position to the position it
// will be at given it's hspeed / vspeed

var x1, y1, x2, y2;

x1 = x + cos(full_direction+pi/2)*mask_radius; y1 = y - sin(full_direction+pi/2)*mask_radius;
x2 = x + cos(full_direction-pi/2)*mask_radius; y2 = y - sin(full_direction-pi/2)*mask_radius;

return (place_meeting(x + full_hspeed, y + full_vspeed, other.id)
        || collision_line(x1, y1, x1 + full_hspeed, y1 + full_vspeed, argument0, false, true) != noone
        || collision_line(x2, y2, x2 + full_hspeed, y2 + full_vspeed, argument0, false, true) != noone)
