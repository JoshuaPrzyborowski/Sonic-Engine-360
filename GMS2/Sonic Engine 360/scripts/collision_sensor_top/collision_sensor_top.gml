// ==== Prototype ======
// collision_sensor_top( mask )
// ===============================================
// Returns collision to the determinated layers with a sensor located at the top of the mask.

mask_index=argument0;

return (!place_free(x-(dsin_val*mask_radius),y-(dcos_val*mask_radius)));
