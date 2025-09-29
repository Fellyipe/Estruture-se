/// obj_dialogue - STEP

// cooldown para evitar ações repetidas em 1 frame
if (nav_cooldown > 0) nav_cooldown -= 1;

// input de avanço (Enter, Space ou clique do mouse)
var advance_pressed = false;
if (nav_cooldown == 0) {
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
        advance_pressed = true;
        nav_cooldown = nav_cooldown_max;
    }
}

// Typewriter: avança caracteres por frames
if (typing) {
    char_frame_accum += 1;
    if (char_frame_accum >= char_delay_frames) {
        char_frame_accum = 0;
        typed_chars += 1;
        if (typed_chars >= string_length(text)) {
            typed_chars = string_length(text);
            typing = false;
            // reset blink timer para aparecer indicador
            blink_timer = 0;
        }
    }
    // Se jogador pressionou e ainda estava digitando -> completar imediatamente
    if (advance_pressed) {
        typed_chars = string_length(text);
        typing = false;
        blink_timer = 0;
    }
} else {
    // texto completo
    blink_timer = (blink_timer + 1) mod (blink_rate*2);
    if (advance_pressed) {
        // fechar a caixa e chamar callback (se houver)
        if (is_callable(on_close)) {
            // chama on_close de forma segura
            on_close();
        }
        // destrói a instância
        instance_destroy(self);
    }
}
