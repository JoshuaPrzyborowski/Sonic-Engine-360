// ==== Prototype ======
// collision_sensor_bottom( mask )
// ===============================================
// Returns collision to the determinated layers with a sensor located at the bottom of the mask.

mask_index=argument0;

return (!place_free(x+(dsin_val*mask_radius),y+(dcos_val*mask_radius)));
