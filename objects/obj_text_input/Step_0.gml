caret_timer += 1;
if (caret_timer >= caret_blink) {
    caret_timer = 0;
    caret_on = !caret_on;
}

// captura texto digitado
if (string_length(keyboard_string) > 0) {
    var s = keyboard_string;
    //keyboard_clear();
    keyboard_string = "";
	if (string_length(input_text) + string_length(s) > max_length) {
        s = string_copy(s, 1, max_length - string_length(input_text));
    }
    input_text += s;
}

// backspace
if (keyboard_check_pressed(vk_backspace)) {
    if (string_length(input_text) > 0) {
        input_text = string_delete(input_text, string_length(input_text), 1);
    }
}

// confirmar com Enter
if (keyboard_check_pressed(vk_enter)) {
    //if (target_id != noone && instance_exists(target_id)) {
    //    with (target_id) {
	//		despoint_to_tower(value);
    //        // grava o texto no obj_pointer (ou onde você quiser)
    //        value = other.input_text;
	//		if occupied point_to_tower(value)
    //    }
    //}
	
	// Proteção
	if (!variable_instance_exists(self, "target_id")) {
        global.ui_blocked = false;
        instance_destroy(self);
        exit;
    }
    if (!instance_exists(target_id)) {
        // pointer alvo desapareceu — fecha a UI
        global.ui_blocked = false;
        instance_destroy(self);
        exit;
    }
	
	var txt = string_trim(string(input_text));
	
	with(target_id) {
		value = txt;	
	}
	
	set_pointer_target_by_address(target_id, input_text);
    global.ui_blocked = false;
    instance_destroy(self);
	
    exit;
}

// cancelar com Tab
if (keyboard_check_pressed(vk_tab)) {
    global.ui_blocked = false;
    instance_destroy(self);
    exit;
}
