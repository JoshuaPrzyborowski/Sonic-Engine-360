function generate_baked_walls(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	// This is an optional script that can be called to bake all the static wall instances in a room into object's with separate
	// generated sprite tiles. This can hugely increase the efficiency of the game depending on how it is set-up but it can also
	// take a few seconds to run through the script when it's called, the more tile pieces and instances the longer it will take.

	var wall_parent_ind, tile_width, tile_height, area_x, area_y, area_width, area_height, depth_layer_map, depth_loop, i, xi, yi, depth_layer_list, depth_layer_size, surf, drawn_on, spr_gen;

	// Initialize script parameters
	wall_parent_ind     = argument0;
	tile_width          = argument1;
	tile_height         = argument2;
	area_x              = argument3;
	area_y              = argument4;
	area_width          = argument5;
	area_height         = argument6;

	// Loop through every wall instance and add to a seperate ds_list depending on the instance's depth
	depth_layer_map = ds_map_create();
	with (wall_parent_ind)
	{
	    if !(ds_map_exists(depth_layer_map, depth))
	    {
	        ds_map_add(depth_layer_map, depth, ds_list_create());
	    }
	    ds_list_add(ds_map_find_value(depth_layer_map, depth), id);
	}

	// Exit if not wall instances exist
	if (ds_map_empty(depth_layer_map))
	    return 0;

	depth_loop = ds_map_find_first(depth_layer_map);
	repeat (ds_map_size(depth_layer_map))
	{
	    depth_layer_list = ds_map_find_value(depth_layer_map, depth_loop);
	    depth_layer_size = ds_list_size(depth_layer_list);

	    // Loop through the different tile areas on the screen
	    for (xi = area_x; xi < area_width + tile_width; xi += tile_width)
	    {
	        for (yi = area_y; yi < area_height + tile_height; yi += tile_height)
	        {
	            // Initialize surfaces
	            surf = surface_create(tile_width, tile_height);
	            if (surf == -1)
	                return 0;

	            surface_set_target(surf);
	            draw_clear_alpha(c_aqua, 0);
	            drawn_on = false;

	            // Loop through the ds_list's containing the instances
	            for (i = 0; i < depth_layer_size; i += 1)
	            {
	                with (ds_list_find_value(depth_layer_list, i))
	                {
	                    // Check if instance is within the drawing area region
	                    if (bbox_left < xi + tile_width && bbox_right > xi && bbox_top < yi + tile_height && bbox_bottom > yi)
	                    {
	                        draw_sprite_ext(sprite_index, image_index, x - xi, y - yi, image_xscale, image_yscale, image_angle, c_white, image_alpha);
	                        drawn_on = true;
	                    }
	                }
	            }

	            // Create an object with a sprite_index generated from the tile area surface (but only if the tile area was drawn on)
	            if (drawn_on)
	            {
	                with (instance_create(0, 0, wall_parent_ind))
	                {
	                    spr_gen = sprite_create_from_surface(surf, 0, 0, surface_get_width(surf), surface_get_height(surf), false, false, 0, 0);
	                    sprite_index = spr_gen;
	                    mask_index = -1;
	                    x = xi;
	                    y = yi;
	                    depth = depth_loop;

	                    /* You can uncomment the below line to save the generated sprite tile pngs to file.
	                       You can then add the ojbect tiles to your game manually if you wish. */
	                    //sprite_save(spr_gen, 0, "wall_layer_" + string(depth_loop) + "_" + string(xi) + "_" + string(yi) + ".png");
	                }
	            }

	            // Reset the surfaces
	            surface_reset_target();
	            surface_free(surf);
	        }
	    }

	    depth_loop = ds_map_find_next(depth_layer_map, depth_loop);
	}

	// Loop through all the previous wall instances and destroy them (as we are using the newly created object tiles now)
	depth_loop = ds_map_find_first(depth_layer_map);
	repeat (ds_map_size(depth_layer_map))
	{
	    depth_layer_list = ds_map_find_value(depth_layer_map, depth_loop);
	    depth_layer_size = ds_list_size(depth_layer_list);

	     for (i = 0; i < depth_layer_size; i += 1)
	         with (ds_list_find_value(depth_layer_list, i))
	            instance_destroy();

	    depth_loop = ds_map_find_next(depth_layer_map, depth_loop);
	}

	return 1;



}
