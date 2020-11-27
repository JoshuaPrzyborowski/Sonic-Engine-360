/// Time Counter Codes

    // Invincibility code
    invisible = 0;
    if (invincibility != -1)
    {
        invincibility += 1;
        if (invincibility < inv_box)            // Invincibility from being hit when not on invinciblity box counter
        {
            if (invincibility > 200)                // Reset and disable invincibility again after 200 steps
                invincibility = -1;     

            if ((current_step div 6) mod 2 != 0)    // Exit the player draw every 6 steps to make it flash
                invisible = 1;
        }
        else if (invincibility < inv_action)    // Now it's invincibility from box when not on invinciblity action counter
        {
            if (invincibility > inv_box + 900)      // Reset and disable invincibility from box after 900 steps
            {
                invincibility = -1;
//                player_music(backing_music);      // Reset to backing_music (which you can add yourself)
            }
        }
        else                                    // Now it's the invinciblity action counter
        {
            if (invincibility > inv_action + 6)
            {
                invincibility = -1;
            }            
        }
    }

    if (sneekers != -1)
    {
        sneekers += 1;
        if (sneekers > 900)
        {
            sneekers = -1;
            acc = 0.1;
            max_runspeed = 12;
//                player_music(backing_music);      // Reset to backing_music (which you can add yourself)
        }
    }

    if (shield_action != -1)
    {
        shield_action += 1;
        if (shield_action > 18)
            shield_action = -1;
    }
/// Animation system

    switch (action)
    {

    // -> Main animations when no action
    case act_none:
        if (ground)
        {
            if (hsp == 0)      // -> Standing animations
            {
                if (pushing)
                {
                    animation = ani_push;
                }
                else if (balancing != 0)     // -> Balancing animations
                {
                    if (balancing * xdir == 1)
                    {
                        animation = ani_balance_forwards;
                    }
                    else
                    {
                        animation = ani_balance_backwards;
                    }
                }
                else if (wait_time < 660)
                {
                    animation = ani_stand;                
                }
                else if (animations_frame < 3)
                {
                    animation = ani_wait_start;
                }
                else
                {
                    animation = ani_wait_tap;
                }
            }
            else    // -> Moving animations
            {
                if ((animation == ani_brake || (abs(hsp) > 8 && abs(((((angle - 0) mod 360) + 540) mod 360) - 180) < 15)) && ((hsp > 0 && KEY_LEFT) || (hsp < 0 && KEY_RIGHT)))    // -> Braking animation under the correct circumstances
                {
                    if (animation != ani_brake)
                        sound_play(SndBrake);
                    animation = ani_brake;
                }
                else if (abs(hsp) < 8)
                {
                    animation = ani_walk;
                    animations_speed = ani_speed[ani_walk] + abs(hsp*3);
                }
                else
                {
                    animation = ani_run;
                    animations_speed = ani_speed[ani_run] + abs(hsp*2);
                }
            }
        }
        else    // Falling animation
        {
            animation = ani_walk;
            animations_speed = ani_speed[ani_walk] + abs(hsp*3);
        }
        break;

    case act_roll:
        animation = ani_roll;
        animations_speed = ani_speed[ani_roll] + abs(hsp*2);
        break;

    case act_lookdown:
        animation = ani_lookdown;
        break;

    case act_lookup:
        animation = ani_lookup
        break;

    case act_spindash:
        animation = ani_spindash;
        draw_sprite_ext(SpinSmoke, current_step mod 14, x, y, xdir, 1, 0, c_white, 0.8);  // Add smoke animation for spin dash
        break;

    case act_spring:
        animation = ani_spring;
        break;

    case act_hit:
        animation = ani_hit;
        break;
    
    case act_death:
        animation = ani_death;
        break;
    }
    
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

    // Get angle of the animation
    if (action == act_spindash || pushing)
    {
        animations_angle = 0;
    }
    else if (ground || action == act_roll)
    {
        animations_angle = angle;
    }
    else if (animations_angle != 0)
    {
        if (animations_angle <= 180)
        {
            animations_angle -= 8;
            if (animations_angle < 0) animations_angle = 0;
        }
        else
        {
            animations_angle += 8;
            if (animations_angle >= 360) animations_angle = 0;
        }    
    }
/// Draw the player and shields

    var xpos, ypos;
    if (!invisible)
    {
        // Shield Position
        xpos = x + lengthdir_y(9, animations_angle);
        if (action == act_roll)
            ypos = y - lengthdir_x(4, animations_angle);
        else
            ypos = y - lengthdir_x(9, animations_angle);

        // Fire Shield Back
        if (shield == 2 && shield_action == -1 && invincibility == -1)
            draw_sprite_ext(SprShieldFire, 1 + (current_step div 4) * 2, xpos, ypos, xdir, 1, 0, c_white, 1);

        // Draw the character !!
        draw_sprite_ext(character, animations_frame, x, y, xdir, 1, animations_angle, c_white, 1);

        if (invincibility >= inv_action)    //  Invincibility Action Effect
            draw_sprite_ext(SprInvAction, (invincibility - inv_action) - 1, xpos, ypos , xdir, 1, 0, c_white, 1);
        else if (invincibility >= inv_box)
        {
            //  Invincibility Box Effect
            var i;
            repeat (2)
            {
                for (i = 0; i < inv_sparks; i += 1)
                {
                
                    if (!inv_spark[i, 0])
                        break;
                }
                inv_spark[i, 0] = 1;                                // spark alive
                inv_spark[i, 1] = xpos + lengthdir_x(4, angle);     // spark x
                inv_spark[i, 2] = ypos + lengthdir_y(4, angle);     // spark y
                inv_spark[i, 3] = 5 + random(15);                   // spark radius
                inv_spark[i, 4] = random(360);                      // spark direction
                inv_spark[i, 5] = 0;                                // image_index
                inv_spark[i, 6] = 0;                                // spark steps
                
                if (i == inv_sparks)
                    inv_sparks += 1;
            }
              
            for (i = 0; i < inv_sparks; i += 1)
            {
                if (!inv_spark[i, 0]) continue;
                
                if (inv_spark[i, 3] < 20)
                    inv_spark[i, 3] += 0.25;

                inv_spark[i, 4] += 5;

                inv_spark[i, 5] += 1/8;
                if (inv_spark[i, 5] >= 3.5)
                    inv_spark[i, 0] = 0;

                if (inv_spark[i, 6] >= 15)
                    inv_spark[i, 0] = 0;
                inv_spark[i, 6] += 1;

                draw_sprite(SprInvincibility, inv_spark[i, 5], inv_spark[i, 1] + lengthdir_x(inv_spark[i, 3],inv_spark[i, 4]), inv_spark[i, 2] + lengthdir_y(inv_spark[i, 3], inv_spark[i, 4]))
            }
        }

        if (invincibility == -1)
        {
            // Shields
            switch (shield)
            {

            case 1:     // Basic Shield
                draw_sprite_ext(SprShieldBasic, current_step div 6, xpos, ypos, xdir, 1, 0, c_white, 1);
                break;

            case 2:     // Fire Shield Front
                if (shield_action == -1)
                    draw_sprite_ext(SprShieldFire, (current_step div 4) * 2, xpos, ypos, xdir, 1, 0, c_white, 1);
                else
                    draw_sprite_ext(SprShieldFireAction, current_step div 4, xpos, ypos, xdir, 1, 0, c_white, 1);
                break;

            case 3:     // Electricity Shield
                draw_sprite_ext(SprShieldElectricity, current_step div 5, xpos, ypos, xdir, 1, 0, c_white, 1);
                if (shield_action != -1) 
                {
                    draw_sprite_ext(SprShieldElectricityAction, (shield_action - 1) div (18/4), shield_xpos + 25 + shield_action*3, shield_ypos - 16 + shield_action/10, 1, 1, 0, c_white, 1);
                    draw_sprite_ext(SprShieldElectricityAction, (shield_action - 1) div (18/4), shield_xpos - 25 - shield_action*3, shield_ypos - 16 + shield_action/10, 1, 1, 0, c_white, 1);
                    draw_sprite_ext(SprShieldElectricityAction, (shield_action - 1) div (18/4), shield_xpos + 25 + shield_action*3, shield_ypos + 35 + shield_action*3, 1, 1, 0, c_white, 1);
                    draw_sprite_ext(SprShieldElectricityAction, (shield_action - 1) div (18/4), shield_xpos - 25 - shield_action*3, shield_ypos + 35 + shield_action*3, 1, 1, 0, c_white, 1);
                }
                break;

            case 4:     // Water Shield
                if (shield_action == -1)
                    draw_sprite_ext(SprShieldWater, current_step div 4, xpos, ypos, xdir, 1, 0, c_white, 1);
                else
                    draw_sprite_ext(SprShieldWaterAction, 0, xpos, ypos, xdir, 1, 0, c_white, 1);
                break;
            }
        }
    }
