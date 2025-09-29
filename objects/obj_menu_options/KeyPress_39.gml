var item = menu_items[selected_index];

if (item.var_name == "volume_music") {
	audio_group_set_gain(BGM, audio_group_get_gain(BGM) + 0.05, 0);
}

if (item.var_name == "volume_sfx") {
	audio_group_set_gain(SFX, audio_group_get_gain(SFX) + 0.05, 0);
}

if (item.var_name == "resolution") {
	resolution_index = (resolution_index + 1) mod array_length(item.options);
}

/*switch (item.type) {
  
  case "slider":
    // Ajusta o valor na variável global apropriada
    if (keyboard_check(vk_left)) {
      global[entry.var_name] = max(entry.min, global[entry.var_name] - entry.step);
      // Aplica no grupo certo
      if (entry.var_name == "volume_music") {
        audio_group_gain(AudioGroup.Music, global.volume_music);
      } else {
        audio_group_gain(AudioGroup.Sounds, global.volume_sfx);
      }
    }
    if (keyboard_check(vk_right)) {
      global[entry.var_name] = min(entry.max, global[entry.var_name] + entry.step);
      if (entry.var_name == "volume_music") {
        audio_group_gain(AudioGroup.Music, global.volume_music);
      } else {
        audio_group_gain(AudioGroup.Sounds, global.volume_sfx);
      }
    }
    break;
    
  case "select":
    if (keyboard_check_pressed(vk_left)) {
      resolution_index = (resolution_index - 1 + array_length(entry.options)) mod array_length(entry.options);
      apply_resolution(entry.options[resolution_index]);
    }
    if (keyboard_check_pressed(vk_right)) {
      resolution_index = (resolution_index + 1) mod array_length(entry.options);
      apply_resolution(entry.options[resolution_index]);
    }
    break;
}
*/