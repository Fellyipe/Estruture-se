//caret_timer += 1;
//if (caret_timer >= caret_blink) {
//    caret_timer = 0;
//    caret_on = !caret_on;
//}

//// captura texto digitado
//if (string_length(keyboard_string) > 0) {
//    var s = keyboard_string;
//    //keyboard_clear();
//    keyboard_string = "";
//	if (string_length(input_text) + string_length(s) > max_length) {
//        s = string_copy(s, 1, max_length - string_length(input_text));
//    }
//    input_text += s;
//}

//// backspace
//if (keyboard_check_pressed(vk_backspace)) {
//    if (string_length(input_text) > 0) {
//        input_text = string_delete(input_text, string_length(input_text), 1);
//    }
//}

//// confirmar com Enter
//if (keyboard_check_pressed(vk_enter)) {
//    //if (target_id != noone && instance_exists(target_id)) {
//    //    with (target_id) {
//	//		despoint_to_tower(value);
//    //        // grava o texto no obj_pointer (ou onde você quiser)
//    //        value = other.input_text;
//	//		if occupied point_to_tower(value)
//    //    }
//    //}
	
//	// Proteção
//	if (!variable_instance_exists(self, "target_id")) {
//        global.ui_blocked = false;
//        instance_destroy(self);
//        exit;
//    }
//    if (!instance_exists(target_id)) {
//        // pointer alvo desapareceu — fecha a UI
//        global.ui_blocked = false;
//        instance_destroy(self);
//        exit;
//    }
	
//	var txt = string_trim(string(input_text));
	
//	with(target_id) {
//		value = txt;	
//	}
	
//	set_pointer_target_by_address(target_id, input_text);
//    global.ui_blocked = false;
//    instance_destroy(self);
	
//    exit;
//}

//// cancelar com Tab
//if (keyboard_check_pressed(vk_tab)) {
//    global.ui_blocked = false;
//    instance_destroy(self);
//    exit;
//}






// Animação de entrada suave (interpolação)
display_scale = lerp(display_scale, 1, 0.15);

// Lógica do cursor de texto (piscar suave com seno)
caret_timer += caret_blink_speed;
caret_alpha = 0.5 + abs(sin(caret_timer)) * 0.75; // Faz o alfa variar suavemente

if (error_timer > 0) {
    error_timer -= 1;
}

// Captura texto digitado
//if (string_length(keyboard_string) > 0) {
//    input_text += keyboard_string;
//    keyboard_string = "";
//    // Trunca o texto se exceder o limite
//    if (string_length(input_text) > max_length) {
//        input_text = string_copy(input_text, 1, max_length);
//    }
//}

// --- Captura e Filtro de Texto em Tempo Real ---
if (string_length(keyboard_string) > 0) {
    var new_chars = string_lower(keyboard_string); // Normaliza para minúsculas.
    keyboard_string = "";

    for (var i = 1; i <= string_length(new_chars); i++) {
        var char = string_char_at(new_chars, i);
        
        // Verifica se o caractere é um dos permitidos (hex + 'x' + 'nul')
        if (string_pos(char, "0123456789abcdefxnul") > 0) {
            if (string_length(input_text) < max_length) {
                input_text += char;
            }
        }
        // Opcional: Adicionar um som de erro aqui se o caractere for inválido.
    }
}

// Backspace
if (keyboard_check_pressed(vk_backspace)) {
    if (string_length(input_text) > 0) {
        input_text = string_delete(input_text, string_length(input_text), 1);
    }
}

//// Confirmar com Enter
//if (keyboard_check_pressed(vk_enter)) {
//    // ... (o seu código de confirmação para o target_id está ótimo) ...
    
//    // Proteção
//    if (!variable_instance_exists(self, "target_id") || !instance_exists(target_id)) {
//        global.ui_blocked = false;
//        instance_destroy(self);
//        exit;
//    }
    
//    var txt = string_trim(string(input_text));
    
//    with(target_id) {
//        value = txt;
//    }
    
//    set_pointer_target_by_address(target_id, input_text);
//    global.ui_blocked = false;
//    instance_destroy(self);
//    exit;
//}

// --- Validação e Confirmação com Enter ---
if (keyboard_check_pressed(vk_enter)) {
    
    var is_valid = false;
    var txt = input_text;

    // Checagem 1: É "null"?
    if (txt == "null") {
        is_valid = true;
    }
    // Checagem 2: Está no formato "0xXXXX"?
    else if (string_length(txt) == 6 && string_char_at(txt, 1) == "0" && string_char_at(txt, 2) == "x") {
        // Valida se os 4 últimos dígitos são de fato hexadecimais
        var is_hex_ok = true;
        for (var i = 3; i <= 6; i++) {
            var char = string_char_at(txt, i);
            if (string_pos(char, "0123456789abcdef") == 0) {
                is_hex_ok = false;
                break;
            }
        }
        if (is_hex_ok) {
            is_valid = true;
        }
    }
    
    // Se o formato for válido, salva e destrói o objeto.
    if (is_valid) {
        if (instance_exists(target_id)) {
            with(target_id) {
                value = txt;
            }
            set_pointer_target_by_address(target_id, txt);
        }
        
        global.ui_blocked = false;
        instance_destroy(self);
        exit;
    }
    else {
        // Opcional: Dar feedback visual de erro, como tremer a tela
        // ou piscar a caixa de texto em vermelho. Por enquanto, apenas não fecha.
        // show_debug_message("Formato inválido!");
		error_timer = 300;
    }
}

// Cancelar com Escape
if (keyboard_check_pressed(vk_escape)) {
    global.ui_blocked = false;
    instance_destroy(self);
    exit;
}