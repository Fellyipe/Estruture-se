var item = menu_items[selected_index];

if (item.var_name == "volume_music") {
	audio_group_set_gain(BGM, audio_group_get_gain(BGM) - 0.05, 0);
}

if (item.var_name == "volume_sfx") {
	audio_group_set_gain(SFX, audio_group_get_gain(SFX) - 0.05, 0);
}

if (item.var_name == "resolution") {
	resolution_index = (resolution_index - 1 + array_length(item.options)) mod array_length(item.options);
}