function player_music(argument0) {
	// Handles Music (which you can add yourself)

	if (current_music != -1)
	    sound_stop(current_music);

	if (argument0 != -1)
	    sound_play(argument0);

	current_music = argument0;



}
