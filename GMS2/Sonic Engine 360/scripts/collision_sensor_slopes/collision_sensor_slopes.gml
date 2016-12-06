// ==== Prototype ======
// collision_sensor_slopes( mask )
// ===============================================
// Returns collision to the determinated layers for use on slope detection.

mask_index = argument0;

return (!place_free(x + dsin_val*(mask_radius+8), y + dcos_val*(mask_radius+8)));
