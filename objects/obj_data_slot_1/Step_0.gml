slot_x = x + slot_offset_x;
slot_y = y + slot_offset_y;

// cooldown de overload (se usar)
if (overload_cooldown > 0) {
    overload_cooldown -= 1;
    if (overload_cooldown == 0) overloaded = false;
}

// proximidade do player
// var p = instance_nearest(x, y, obj_player);
// caches o player na primeira vez para evitar instance_nearest
if (!instance_exists(player_ref)) {
    if (instance_number(obj_player) > 0) {
        player_ref = instance_find(obj_player, 0); // assume 1 player
    }
}

var can_interact = (player_ref != noone) && point_distance(x, y, player_ref.x, player_ref.y) <= prompt_distance;

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

if !occupied {
	image_index = 0;
}