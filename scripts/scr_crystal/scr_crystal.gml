//function place_crystal_on_tower(player_inst, tower_id) {
	
//	if (!instance_exists(player_inst) || !instance_exists(tower_id)) return false;
//	if (!variable_instance_exists(player_inst, "carrying_crystal") || player_inst.carrying_crystal == noone) return false;
//	var _cr = player_inst.carrying_crystal;

//	// Checa ocupação
//	if (tower_id.crystal_inst != noone) {
//	    audio_play_sound(snd_error,1,false);
//	    return false;
//	}

//	// encaixa: tower deve ter script place_crystal ou fazemos aqui
//	with (tower_id) {
//	    crystal_inst = _cr;
//	    occupied = true;
//	}
//	with (_cr) {
//	    carrier = noone;
//	    in_tower = tower_id; // guarda referência da torre
//	}
//	// atualiza player
//	player_inst.carrying_crystal = noone;
//	//audio_play_sound(snd_place,1,false);
//	return true;
//}




//function take_from_tower(tower_id, player_inst) {
	
//	if (!instance_exists(tower_id) || !instance_exists(player_inst)) return false;
//	if (tower_id.crystal_inst == noone) return false;
//	if (variable_instance_exists(player_inst, "carrying_crystal") && player_inst.carrying_crystal != noone) return false; // já carrega

//	var _c = tower_id.crystal_inst;
//	// remove do tower
//	with (tower_id) {
//	    crystal_inst = noone;
//	    occupied = false;
//	}
//	// dá ao player
//	with (_c) {
//	    carrier = player_inst;
//	    in_tower = noone;
//	}
//	// set no player
//	player_inst.carrying_crystal = _c;
//	//audio_play_sound(snd_pickup,1,false);
//	return true;
//}






/// Coloca o cristal que o player carrega na torre (se houver espaço).
/// Retorna true se encaixou, false caso contrário.
function place_crystal_on_tower(player_inst, tower_inst) {

	if (!instance_exists(player_inst)) return false;
	if (!instance_exists(tower_inst)) return false;

	// o player precisa ter carrying válido
	if (!variable_instance_exists(player_inst, "carrying") || player_inst.carrying == noone) return false;
	var _c = player_inst.carrying;
	if (!instance_exists(_c)) {
	    // estado inconsistente -> limpar carrying
	    player_inst.carrying = noone;
	    return false;
	}

	// opcional: checar tipo do objeto carregado (garantir que é um cristal)
	// if (object_index != obj_crystal) ...
	// vou assumir que só cristais são carregados quando chamar essa função

	// tower deve ter campo crystal_inst
	if (!variable_instance_exists(tower_inst, "crystal_inst")) return false;

	// se já ocupado, falha (policy: não substitui automaticamente)
	if (tower_inst.crystal_inst != noone) {
	    if (is_undefined(snd_error) == false) audio_play_sound(snd_error,1,false);
	    return false;
	}

	// encaixa: atualiza campos da torre e do cristal
	with (tower_inst) {
	    crystal_inst = _c;
	    occupied = true;
	}

	// atualizar cristal: in_tower e tirar dos braços do player
	with (_c) {
	    in_tower = tower_inst;
	    carried_by = noone;
	    // posiciona exatamente no slot da torre, se existir
	    if (variable_instance_exists(tower_inst, "slot_x") && variable_instance_exists(tower_inst, "slot_y")) {
	        x = tower_inst.slot_x;
	        y = tower_inst.slot_y;
	    } else {
	        // fallback: posiciona sobre a torre
	        x = tower_inst.x;
	        y = tower_inst.y - 12;
	    }
	}

	// atualizar player
	player_inst.carrying = noone;
	player_inst.carry_side = undefined;

	// feedback
	//if (is_undefined(snd_place) == false) audio_play_sound(snd_place,1,false);
	show_debug_message("place_crystal_on_tower: cristal id " + string(_c) + " colocado em tower id " + string(tower_inst));
	return true;
}






/// Retira o cristal da torre (se houver) e coloca no player como carrying.
/// Retorna true se sucesso, false caso contrário.
function take_from_tower(tower_inst, player_inst) {

	if (!instance_exists(tower_inst)) return false;
	if (!instance_exists(player_inst)) return false;

	// torre deve ter cristal
	if (!variable_instance_exists(tower_inst, "crystal_inst")) return false;
	if (tower_inst.crystal_inst == noone) return false;

	// player não pode já carregar algo
	if (variable_instance_exists(player_inst, "carrying") && player_inst.carrying != noone) return false;

	// pegar referência do cristal
	var _c = tower_inst.crystal_inst;
	if (!instance_exists(_c)) {
	    // dado inconsistente — limpa a torre
	    with (tower_inst) {
	        crystal_inst = noone;
	        occupied = false;
	    }
	    return false;
	}

	// remover do tower
	with (tower_inst) {
	    crystal_inst = noone;
	    occupied = false;
	}

	// atualizar cristal: tirar de in_tower e marcar como carregado
	with (_c) {
	    in_tower = noone;
	    carried_by = player_inst; // set para a instância do player
	}

	// atualizar player: set carrying, set carry_side baseado na face atual
	player_inst.carrying = _c;
	player_inst.carry_side = player_inst.face;

	// posiciona cristal na posição de attach do player imediatamente
	if (is_undefined(player_inst.carry_offset)) player_inst.carry_offset = 20;
	var _attach = get_attach_pos(player_inst.x, player_inst.y, player_inst.carry_side, player_inst.carry_offset);
	with (_c) {
	    x = _attach.x;
	    y = _attach.y;
	}

	// feedback
	//if (!is_undefined(snd_pickup)) audio_play_sound(snd_pickup, 1, false);
	show_debug_message("take_from_tower: player carregando cristal id " + string(_c));

	return true;
}



function point_to_tower(my_address) {
	with (obj_pointer) {
		if(address == my_address) {
			incoming_count = 1;	
		}
	}
}

function despoint_to_tower(my_address) {
	with (obj_pointer) {
		if(address == my_address) {
			incoming_count = 0;	
		}
	}
}