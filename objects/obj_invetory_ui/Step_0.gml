if (nav_cooldown > 0) nav_cooldown -= 1;

if (keyboard_check_pressed(ord("I"))) {
    instance_destroy(self); // fecha inventário
    exit;
}

// navegar
if (nav_cooldown == 0) {
    if (keyboard_check_pressed(vk_down)) {
        selected = clamp(selected + 1, 0, array_length(global.inventory)-1);
        nav_cooldown = nav_delay;
        //audio_play_sound(snd_move, 1, false);
    } else if (keyboard_check_pressed(vk_up)) {
        selected = clamp(selected - 1, 0, array_length(global.inventory)-1);
        nav_cooldown = nav_delay;
        //audio_play_sound(snd_move, 1, false);
    } else if (keyboard_check_pressed(vk_enter)) {
        inventory_use(selected);
        //audio_play_sound(snd_select, 1, false);
    } else if (keyboard_check_pressed(ord("D"))) {
        // dropar com confirmação simples
        inventory_drop(selected);
        //audio_play_sound(snd_cancel, 1, false);
        selected = clamp(selected, 0, array_length(global.inventory)-1);
    }
}
         