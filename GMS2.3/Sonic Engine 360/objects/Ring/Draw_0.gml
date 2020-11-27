/// Ring Loss Decay

if (ring_loss)
{
    invisible = 0;
    // Code for the ring decay
    if (decay_count != -1)
    {
        decay_count += 1;
        if (decay_count > decay_life)   // Destroy the ring when the decay time is over
        {
            decay_count = 0;
            instance_destroy();
        }
        if (decay_count > decay_life/2 && (decay_count div 6) mod 2 != 0)   // Start flashing the ring when half it's life is up 
            invisible = 1;
    }
}

/// Standard animation

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
    
    if (!invisible)  // Draw normally as long as invisibility is not set
        draw_sprite_ext(sprite_index, animations_frame, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

