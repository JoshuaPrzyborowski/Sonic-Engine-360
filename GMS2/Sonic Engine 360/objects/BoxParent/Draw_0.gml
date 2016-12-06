// Draw the box animation depending on the current action

    switch (action)
    {

    // Standard box
    case 0:
        draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
        if ((flash_count div 3) mod 2 != 0)
            draw_sprite_ext(SprBoxIcons, box_type, x, y + icon_y, image_xscale, image_yscale, image_angle, c_white, 1);
        flash_count += 1;
        break;

    // Box while exploding
    case 1:
        draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

        if (explosion_count != -1)
        {
            if (explosion_count >= 5 * 8)    // image_number * animation_speed
            {
                explosion_count = -1;
            }
            else
            {
                draw_sprite_ext(SprExplosion, explosion_count div 8, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
                explosion_count += 1;
            }
        }

        if (icon_speed < 0.01)
        {
            icon_speed = 0;
        }
        else
        {
            icon_y -= icon_speed;
            draw_sprite_ext(SprBoxIcons, box_type, x, y + icon_y, image_xscale, image_yscale, image_angle, c_white, icon_speed);
            icon_speed *= 0.95;
        }

        if (explosion_count == -1 && icon_speed == 0)  // If explosion and icon rise is over then set action to 2
            action = 2;
        break;

    // Final box
    case 2:
        draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
    }

