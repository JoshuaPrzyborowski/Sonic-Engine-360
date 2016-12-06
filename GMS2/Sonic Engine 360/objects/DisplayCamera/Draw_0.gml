/// Display Drawing (draws the text SCORE, RING and TIME in top left corner, and Life sprite in bottom left)
    
var time_string, minutes, seconds;
with (Player)
{    
    draw_set_font(fnt_display);
    draw_set_color(c_yellow);
    draw_set_halign(fa_left);
    draw_text(__view_get( e__VW.XView, 0 )+8, __view_get( e__VW.YView, 0 )+8, string_hash_to_newline("SCORE"));
    draw_text(__view_get( e__VW.XView, 0 )+8, __view_get( e__VW.YView, 0 )+24, string_hash_to_newline("TIME"));

    if (rings == 0)
    {
        if ((current_step div 6) mod 2 != 0)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_red);
    }
    draw_text(__view_get( e__VW.XView, 0 )+8, __view_get( e__VW.YView, 0 )+40, string_hash_to_newline("RINGS"));

    draw_set_color(c_white);
    draw_text(__view_get( e__VW.XView, 0 )+63, __view_get( e__VW.YView, 0 )+8, string_hash_to_newline(string(scores)));
    draw_text(__view_get( e__VW.XView, 0 )+63, __view_get( e__VW.YView, 0 )+40, string_hash_to_newline(string(rings)));

    minutes = time_count div 60;
    seconds = floor(time_count - minutes*60);

    if (seconds < 10)
        time_string = string(minutes)+":0"+string(seconds);
    else
        time_string = string(minutes)+":"+string(seconds);

    draw_text(__view_get( e__VW.XView, 0 )+63, __view_get( e__VW.YView, 0 )+24, string_hash_to_newline(time_string));

    draw_sprite(SprLifeDisplay, 0, __view_get( e__VW.XView, 0 )+20, __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )-20);
    draw_set_font(fnt_normal);
    draw_text(__view_get( e__VW.XView, 0 )+46, __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )-20, string_hash_to_newline(string(life)));

    if (fps != 0)
        time_count += (1/fps);

    current_step += 1;
    if (current_step mod 120 == 0)
        room_caption = "fsp: " + string(fps);

    
}

