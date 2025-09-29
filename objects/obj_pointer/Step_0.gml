/// obj_pointer - STEP (versão: E = pegar/colar, R = editar texto)
slot_x = x + slot_offset_x;
slot_y = y + slot_offset_y;

// cooldown de overload (se usar)
if (overload_cooldown > 0) {
    overload_cooldown -= 1;
    if (overload_cooldown == 0) overloaded = false;
}

// proximidade do player
var p = instance_nearest(x, y, obj_player);
var can_interact = (p != noone) && point_distance(x, y, p.x, p.y) <= prompt_distance;

// ========== Tecla E: colocar / pegar ==========
//if (can_interact && keyboard_check_pressed(ord("E"))) {
//    // se o player estiver carregando um cristal: tentar colocar
//    if (variable_instance_exists(p, "carrying_crystal") && p.carrying_crystal != noone) {
//        if (crystal_inst == noone) {
//            place_crystal_on_tower(p, id);
//        } else {
//            //audio_play_sound(snd_error,1,false);
//        }
//    }
//    else {
//        // jogador não carrega nada -> tentar pegar da torre (se houver)
//        if (crystal_inst != noone) {
//            take_from_tower(id, p);
//        } else {
//            // nada para pegar - opcional: som/feedback
//            //audio_play_sound(snd_error,1,false);
//        }
//    }
//}

// ========== Tecla R: abrir editor de texto (sempre que perto) ==========
if (can_interact && keyboard_check_pressed(ord("R"))) {
    // evita abrir duas overlays ao mesmo tempo
    if (!instance_exists(obj_text_input)) {
        var o = instance_create_layer(0, 0, "GUI", obj_text_input);
        // passa referência para que a overlay saiba qual pointer editar
        o.target_id = id;          // id desta instância
        o.init_text = string(value); // valor inicial para mostrar
		o.input_text = string(value);
    }
}
