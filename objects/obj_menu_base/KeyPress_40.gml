var temp_index = selected_index;

selected_index = (selected_index + 1) mod array_length(menu_items);

if (temp_index != selected_index)
	audio_play_sound(snd_sfx_test, 0, false, 1, 0, random_range(0.8, 1.2));