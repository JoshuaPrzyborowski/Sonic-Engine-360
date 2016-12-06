/// Game Motion

    // If death action then to the death movement and disable rest of the step code
    if (action == act_death)
    {
        vsp += 0.3;
        y += vsp;
        if (y > __view_get( e__VW.XView, 0 ) + __view_get( e__VW.HView, 0 ) + 250)   // Once player falls out below the view then restart the room (you can set lifes -= 1 here)
        {
            if (life == 0)
                game_end();
            else
                room_restart();
        }
        return 0;
    }


    // Limit the values of the movement
    if (abs(hsp) > hspl)    hsp = sign(hsp)*hspl;
    if (abs(vsp) > vspl)    vsp = sign(vsp)*vspl;

    //================================================================= 
    // Main horizontal and vertical movement, done by moving the player forward in increments of the hsp and vsp and checking if there is a collision

    var step_repeat, hstep, vstep, hsign, vsign, hstep_x, hstep_y, rmove, lmove, bmove, tmove;

    step_repeat = ceil(max(abs(hsp), abs(vsp)));

    hsign = sign(hsp);
    vsign = sign(vsp);
    done1 = (hsign == 0); done2 = (vsign == 0);
    rmove = (hsign == +1);
    lmove = (hsign == -1);
    bmove = (vsign == +1);
    tmove = (vsign == -1);

    if (step_repeat != 0)
    {
        hstep = hsp/step_repeat;
        vstep = vsp/step_repeat;
        hstep_x = dcos_val*hstep;
        hstep_y = dsin_val*hstep;
    }

    repeat (step_repeat)
    {
       if (!done1)
       {        
            if ((collision_sensor_right(MaskLarge) && rmove) || (collision_sensor_left(MaskLarge) && lmove))
            {
                done1 = true;
            }
            else
            {
                x += hstep_x;
                y -= hstep_y;
            }
        }
        if (!done2)
        {        
            if ((collision_sensor_bottom(MaskLarge) && bmove) || (collision_sensor_top(MaskLarge) && tmove))
            {
                done2 = true;
            }
            else
            {
                y += vstep;
            }
        }

        if (done1 && done2) break;
    }

    if (tmove)
        if (collision_sensor_top(MaskLarge))
            vsp = 0;   // Stop vsp if hit under wall

    //=================================================================      
    // Landing. If we are falling and we landed, if the delimiter lines are colliding, search for new angle.
    if (vsp >= 0 &&
       !ground && 
       collision_sensor_bottom(MaskLarge) &&
       collision_sensor_right_line() &&
       collision_sensor_left_line())
    {
        angle = calculate_angle(0);
        dcos_val = cos(degtorad(angle));
        dsin_val = sin(degtorad(angle));
        if (shield == 4 && shield_action != -1)     // If using the water shield then bounce
        {
            hsp = -vsp*dsin_val*0.75;
            vsp = -vsp*dcos_val*0.75;
            angle = 0;
            dcos_val = 1;
            dsin_val = 0;
            jumping = 1;
        }
        else
        {    
            hsp -= dsin_val*vsp;
            vsp = 0;
            ground = 1;

            jumping = 0;
            shield_action = -1;

             if (action == act_roll || action == act_spring || action == act_hit)
                action = act_none;       // Deactivate the rolling, springing or hit actions
        }
    }

    //=================================================================
    // Wall Collisions, if the side masks are colliding, move the player in order to avoid getting stuck.
    while (collision_sensor_right(MaskLarge))
    {
        x -= dcos_val;
        y += dsin_val;                                                                                        
    }

    while (collision_sensor_left(MaskLarge))
    {
        x += dcos_val;
        y -= dsin_val;                                                                                        
    }

    //=================================================================   
    // Do slopes while we're on the ground.
    if (ground)
    {
        // Slopes up: If the main sensor is colliding with the background, push to up
        while (collision_sensor_main())
        {
            x -= dsin_val;
            y -= dcos_val;  
        }

        // Slopes down: If the main sensor isn't colliding with the background but the slope sensor does, push to down.
        while (!collision_sensor_main() && collision_sensor_slopes(MaskMedium))
        {
            x += dsin_val;
            y += dcos_val;  
        }
    }

    //=================================================================     
    if (ground)
    {
        // Check if the delimeter lines aren't colliding while we are on the ground, if that's true, get impulsed to the air
        if (!collision_sensor_left_line() || !collision_sensor_right_line())
        {
            vsp = -dsin_val*hsp;
            hsp = dcos_val*hsp;
            ground = 0;
            angle = 0;
            dcos_val = 1;
            dsin_val = 0;
        }

       // Or if the player is too slow and we're on the roof or on a wall, fall
       if (angle>70 && angle<290 && abs(hsp)<5.5)
       {
            vsp = -dsin_val*hsp;
            hsp = dcos_val*hsp;
            ground = 0;
            angle = 0;
            dcos_val = 1;
            dsin_val = 0;

            if (action != act_roll)     // go into roll when falling off a wall
            {
                action = act_roll;
                sound_play(SndSpin);
            }
        }

        // Add momentum when rolling on slopes
        if (action == act_roll)
        {
            if ((angle < 90 && hsp < acc) || (angle > 270 && hsp > -acc)) // Accelerate down hills
               hsp += 1.2*acc*-dsin_val;
            if ((angle > 15 && angle < 165 && hsp > acc) || (angle > 195 && angle < 345 && hsp < -acc)) // Flick up curves
               hsp += abs(hsp)*dsin_val*0.005;
        }
    }

    //=================================================================   
    // After moving, get the new angle of the ground while the delimeter lines are colliding
    // and the player is on the ground.
    if (ground && collision_sensor_left_line() && collision_sensor_right_line())
    {
        if (hsp != 0 || vsp != 0)       // Only get a new angle if moving
        {
            angle = calculate_angle(angle);
            dcos_val = cos(degtorad(angle));
            dsin_val = sin(degtorad(angle));
        }
    }
    else
    {
        angle = 0;
        dcos_val = 1;
        dsin_val = 0;
    }

    // Now do vertical Movement.
    if (!ground)
    {
        // If we aren't on the ground and we are falling and the bottom sensor is colliding, land
        if (vsp >= 0 && collision_sensor_bottom(MaskLarge))
        {
            ground = 1;
            vsp = 0;
            if (action == act_roll || action == act_spring || action == act_hit) action =act_none;   // Deactivate rolling, springing and hit actions
        }
    }
    else
    {
        // Otherwise, if we are on the ground and the bottom sensor isn't colliding, fall.
        if (!collision_sensor_bottom(MaskLarge))    
        {
            ground = 0;
        }
    }

    if (!ground)
    {
        // Apply forces if we are falling
        vsp += vfr;
        if (vsp > 0 && action == act_spring)
            action = act_none;     // Stop spring action and change to falling  
    }

    if (action == act_roll)  // If action is rolling use a smaller square mask
    {
        sprite_index = MaskMain;
        mask_index = MaskSquareSmall;
    }
    else
    {
        sprite_index = MaskMain;
        mask_index = MaskSquareTall;
    }

/// Gameplay


    if (action == act_death)  // Death code handled in first code piece, but still need to exit this step code when dead
        return 0;
 
    // First, we query the keyboard and store the key data into the variables, for latter use.
    KEY_LEFT        = keyboard_check(vk_left);
    KEY_RIGHT       = keyboard_check(vk_right);
    KEY_UP          = keyboard_check(vk_up);
    KEY_DOWN        = keyboard_check(vk_down);
    KEY_A_PRESS     = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_control);  
    KEY_A           = keyboard_check(vk_space) || keyboard_check(ord("Z")) || keyboard_check(vk_control);

    // If the player pressed any direction, change
    if (action != act_spindash)
    {
        if (KEY_LEFT)
        {
            xdir=-1;
        }
        else if (KEY_RIGHT)
        {
            xdir=1;   
        }
    }

    // If the player is on the ground, we apply the deacceleration based on the actual angle
    if (ground)
    {
        hsp -= dsin_val*(fric_gnd);
    }

    if (action == act_roll || action == act_hit)
        fric = fric_rol;    // Less friction when rolling or hit
    else
        fric = fric_nat;    // Standard friction

    // Accelerate or deaccelerate if the player pressed the keys
    if (KEY_LEFT)
    {
        if (action == act_roll && ground)
        {
            if (hsp >= 0) hsp -= acc;                   // If the player pressed the left key and the player is rolling right on the ground, deaccelerate
        }
        else if (action != act_spindash && action != act_lookup && action != act_lookdown && action != act_hit)
        {
            if (hsp >= 0) hsp -= acc*4;                         // If the player pressed the left key and the player was moving to the right, deaccelerate faster
            if (hsp < 0 && hsp > -max_runspeed) hsp -= acc;     // otherwise, do normal acceleration
            fric = fric_mov;                                    // Set natural friction lower when moving
        }
    }
    else if (KEY_RIGHT)                      
    {
        if (action == act_roll && ground)
        {
            if (hsp <= 0) hsp += acc;                   // Same for right when rolling on the ground
        }
        else if (action != act_spindash && action != act_lookup && action != act_lookdown && action != act_hit)
        {
            if (hsp <= 0) hsp += acc*4;                         // Same for the right, deaccelerate faster
            if (hsp > 0 && hsp < max_runspeed) hsp += acc;      // or do normal acceleration
            fric = fric_mov;                                    // Set natural friction lower when moving
        }
    }

    // Natural Friction
    if (hsp > 0) hsp -= fric;                     // While going to the right, deaccelerate friction amount
    if (hsp < 0) hsp += fric;                     // While going to the left, deaccelerate friction amount

    if (hsp > 0 && hsp < fric) hsp = 0;           // If the speed is lower than deacceleration, set to 0
    if (hsp < 0 && hsp > -fric) hsp = 0;          // If the speed is lower than deacceleration, set to 0

    // Check for collisions on the sides. If those are true, set the speed to 0.
    var stood_still_on_fairly_flat_surface;
    stood_on_fairly_flat_surface = (ground && action==act_none && abs(((((angle - 0) mod 360) + 540) mod 360) - 180) < 3);

    pushing = false;
    if (collision_sensor_right(MaskExtraLarge) && hsp>0)
    {
        hsp = 0;
        if (stood_on_fairly_flat_surface)
            pushing = true;
    }
    if (collision_sensor_left(MaskExtraLarge) && hsp<0)
    {
        hsp = 0;
        if (stood_on_fairly_flat_surface)
            pushing = true;
    }

    // Check for balancing when at platform edge
    balancing = 0;
    if (stood_on_fairly_flat_surface && hsp == 0 && vsp == 0)
    {
        if (!collision_sensor_right_line())
            balancing = 1;
        else if (!collision_sensor_left_line())
            balancing = -1;
    }

    if (jump_factor != -1)
    {
        if (KEY_A && jump_factor < 10)
        {
            hsp += jump_hsp/80;
            vsp += jump_vsp/40;
            jump_factor += 1;
        }
        else
        {
            jump_factor = -1;
        }
    }

    if (KEY_A_PRESS && ground)
    {
        if (action == act_lookdown || action == act_spindash)  // If action is looking down then start Spin Dash
        {
            action = act_spindash;     // Set action to Spin Dash
            sound_play(SndDashCharge);
        }
        else  // Jump
        {
            vsp = dcos_val*jmp-dsin_val*hsp;
            hsp = dcos_val*hsp+dsin_val*jmp;

            // Default angle values
            ground = 0;
            angle = 0;     
            dcos_val = 1;
            dsin_val = 0;

            jumping = 1;             // Set jumping action variable
            jump_factor = 0;         // Used for variable jump height
            jump_vsp = vsp;
            jump_hsp = hsp;
            action = act_roll;       // Set action to rolling when jumping
            sound_play(SndJump);
        }
    }
    else
    {
        // Shields
        if (KEY_A_PRESS && action = act_roll && jumping == 1)
        {
            switch (shield)
            {

            case 0:
                if (invincibility == -1)
                    invincibility = inv_action;
                jumping = 0;
                sound_play(SndInvAction);
                break;

            case 2:
                sound_play(SndShieldFireAction);
                hsp = 15*xdir;
                shield_action = 0;
                jumping = 0;
                break;

            case 3:
                sound_play(SndShieldElectricityAction);
                hsp /= 2;
                vsp = -8;
                shield_xpos = x;    // x position for sparks
                shield_ypos = y;    // y position for sparks
                shield_action = 0;
                jumping = 0;
                break;

            case 4:
                sound_play(SndShieldWaterAction);
                hsp = 0;
                vsp = 12;
                shield_action = 0;
                jumping = 0;
                break;
            }
        }
    }
    
    if (ground && abs(hsp) < rol_minsp/2)
    {
        if (action==act_roll) action = act_none;     // Stop rolling if hardly moving
    }

    if (KEY_DOWN && ground)
    {
        if (hsp == 0)
        {
            if (action == act_none) action = act_lookdown;      // Set action looking down
        }
        else if (abs(hsp) > rol_minsp && !KEY_LEFT && !KEY_RIGHT && action != act_roll)
        {
            action = act_roll;     // Start rolling
            sound_play(SndSpin);
        }
    }

    if (action == act_lookdown && !KEY_DOWN)
    {
        action = act_none;     // Deactivate looking down if down is no longer being pressed
    }

    if (action == act_spindash && !KEY_DOWN)
    {
        hsp=spind*xdir;             // Set spin dash in motion after releasing down
        action = act_roll;          // Start rolling when spin dashing
        sound_stop(SndDashCharge);
        sound_play(SndDashGo);
    }

    if (KEY_UP && ground && hsp == 0)
    {
        if (action == act_none) action = act_lookup;        // Set action looking up
    }

    if (action == act_lookup && !KEY_UP)
    {
        action = act_none;     // Deactivate looking up if down is no longer being pressed
    }

    //=================================================================
    // Increase wait time when doing nothing
    if (action == act_none && ground & hsp == 0 && vsp == 0 && !pushing)
        wait_time += 1;
    else
        wait_time = 0;

    //=================================================================
    // Get the full hspeed, vspeed and direction of the Player as they would be used by the standard variables
    full_hspeed = hsp*dcos_val;
    full_vspeed = vsp-hsp*dsin_val;
    full_direction = arctan2(-full_vspeed, full_hspeed); // In radians

    //=================================================================   
    // Set the mask depending on the action

    if (action==act_roll)  // If action is rolling use a smaller square mask
    {
        sprite_index=MaskMain;
        mask_index=MaskSquareSmall;
    }
    else
    {
        sprite_index=MaskMain;
        mask_index=MaskSquareTall;
    }

