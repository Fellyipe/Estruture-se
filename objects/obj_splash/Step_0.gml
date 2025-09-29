/// Carrega os recursos
if (current_load < array_length(loading_groups)) {
    if (audio_group_is_loaded(loading_groups[current_load])) {
        current_load += 1;
        if (current_load < array_length(loading_groups)) {
            audio_group_load(loading_groups[current_load]);
        }
    }
} else {
    loading_complete = true;
}

/// Detecta se o jogador quer pular a splash
if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any)) {
    if (state != "fade_out" and loading_complete) {
        state = "fade_out";
        frame_count = 0;
    }
}

/// Atualiza contador
frame_count += 1;

/// Lógica de transição
switch (state) {
    
    case "fade_in":
        // incrementa alpha de 0→1
        alpha = clamp(frame_count / fade_in_time, 0, 1);
        if (frame_count >= fade_in_time) {
            state       = "hold";
            frame_count = 0;
        }
        break;
        
    case "hold":
        alpha = 1;
        if (frame_count >= hold_time and loading_complete) {
            state       = "fade_out";
            frame_count = 0;
        }
        break;
        
    case "fade_out":
        // decrementa alpha de 1→0
        alpha = clamp(1 - frame_count / fade_out_time, 0, 1);
        if (frame_count >= fade_out_time) {
            // troca para a room do menu principal
            room_goto(next_room);
        }
        break;
}
