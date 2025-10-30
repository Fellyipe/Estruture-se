/// Step - obj_cinematic_text
// Fade in
if (_state == "fading_in") {
    overlay_alpha += fade_speed;
    if (overlay_alpha >= overlay_target) {
        overlay_alpha = overlay_target;
        _state = "visible";
    }
}

// Input quando visível
if (_state == "visible") {
    if (!_input_locked && (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space))) {
        _input_locked = true;
        if (!is_undefined(snd_confirm) && snd_confirm != noone) audio_play_sound(snd_confirm, 1, false);
        _state = "fading_out";
    }
}

// Fade out e troca de room
if (_state == "fading_out") {
    overlay_alpha -= fade_speed;
    if (overlay_alpha <= 0) {
        overlay_alpha = 0;
        global.ui_blocked = false;
        // Garante que next_room esteja definido
        if (is_undefined(next_room)) next_room = rm_lobby;
        room_goto(next_room);
    }
}
