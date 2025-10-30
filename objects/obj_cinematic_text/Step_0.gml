/// Step - obj_cinematic_text

var _dt = delta_time / 1000000.0;

switch (_state) {
    case "fading_in":
        timer += _dt;
        if (timer >= fade_duration_seconds) {
            timer = fade_duration_seconds;
            _state = "visible";
        }
        break;

    case "visible":
        var current_paragraph_text = paragraphs[current_paragraph_index];
        var is_last_paragraph = (current_paragraph_index == array_length(paragraphs) - 1);

        // Efeito Typewriter no parágrafo atual
        if (text_current_length < string_length(current_paragraph_text)) {
            text_current_length += chars_per_second * _dt;
            text_current_length = min(text_current_length, string_length(current_paragraph_text));
        }

        // Input do jogador
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
            var is_paragraph_finished = (text_current_length >= string_length(current_paragraph_text));

            // Se o parágrafo atual ainda não terminou, acelera para o final DELE
            if (!is_paragraph_finished) {
                text_current_length = string_length(current_paragraph_text);
            } 
            // Se o parágrafo terminou, mas não é o último, avança para o próximo
            else if (!is_last_paragraph) {
                current_paragraph_index++;
                text_current_length = 0; // Reseta o typewriter para o novo parágrafo
            }
            // Se o parágrafo terminou E é o último, inicia o fade-out
            else {
                _state = "fading_out";
                timer = fade_duration_seconds;
                if (snd_confirm != noone) audio_play_sound(snd_confirm, 1, false);
            }
        }
        break;

    case "fading_out":
        timer -= _dt;
        if (timer <= 0) {
            timer = 0;
            global.ui_blocked = false;
            if (room_exists(next_room)) {
                room_goto(next_room);
            }
        }
        break;
}