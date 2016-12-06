// ==== Prototype ======
// collision_sensor_right( mask )
// ===============================================
// Returns collision to the determinated layers with a sensor located at the right to the mask.

mask_index=argument0;

return (!place_free(x+(dcos_val*mask_radius)-(dsin_val*4),y-(dsin_val*mask_radius)-(dcos_val*4)));
