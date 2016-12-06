
    animation = action;

    //==========================================================
    // Core of the animation system

    // If animation changed, change to the new parameters...
    if (animation != animations_old)
    {
        animations_framemin = ani_framemin[animation];
        animations_framemax = ani_framemax[animation];
        animations_return = ani_return[animation];    
        animations_speed = ani_speed[animation];

        animations_frame = animations_framemin;
        animations_timer = 0;
        animations_old = animation;
    }

    // Add to the timer
    animations_timer += animations_speed

    if (animations_timer >= 100)  // Check if we are ready to change of frame
    {    
        animations_timer = 0;
        animations_frame += 1;
        
        if (animations_frame > animations_framemax)
        {
            animations_frame = animations_return;
        }
    }

    // Draw the object
    draw_sprite_ext(sprite_index, animations_frame, x, y, image_xscale, image_yscale, 0, c_white, 1);

