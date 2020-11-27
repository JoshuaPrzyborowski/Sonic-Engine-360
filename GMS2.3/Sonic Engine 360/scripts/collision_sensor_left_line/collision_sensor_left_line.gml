function collision_sensor_left_line() {
	// ==== Prototype ======
	// collision_sensor_left_line( )
	// ===============================================
	// Returns collision to the determinated layers within the delimeters lines

	sprite_index=MaskLine;
	mask_index=MaskLine;
	image_angle = angle;

	var col_true;
	col_true = (!place_free(x-(dcos_val*8)+(dsin_val*mask_radius),y+(dsin_val*8)+(dcos_val*mask_radius)));

	image_angle = 0;
	return col_true;



}
