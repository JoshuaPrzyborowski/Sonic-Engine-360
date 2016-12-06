// ==== Prototype ======
// collision_sensor_left( mask )
// ===============================================
// Returns collision to the determinated layers with a sensor located at the left to the mask.

mask_index=argument0;

return (!place_free(x-(dcos_val*mask_radius)-(dsin_val*4),y+(dsin_val*mask_radius)-(dcos_val*4)));
