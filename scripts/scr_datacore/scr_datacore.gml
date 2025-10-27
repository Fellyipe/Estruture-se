




/// Coloca o datacore que o player carrega na torre (se houver espaço).
/// Retorna true se encaixou, false caso contrário.
function place_datacore_on_tower(player_inst, tower_inst) {

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

	// opcional: checar tipo do objeto carregado (garantir que é um datacore)
	if (_c.object_index != obj_datacore) return false 

	// tower deve ter campo datacore_inst
	if (!variable_instance_exists(tower_inst, "datacore_inst")) return false;

	// se já ocupado, falha (policy: não substitui automaticamente)
	if (tower_inst.datacore_inst != noone) {
	    //if (is_undefined(snd_error) == false) audio_play_sound(snd_error,1,false);
	    return false;
	}

	// encaixa: atualiza campos da torre e do datacore
	with (tower_inst) {
	    datacore_inst = _c;
	    occupied = true;
		
		if (variable_instance_exists(_c, "payload")) {
	        payload = string(_c.payload);
	    } else {
	        payload = ""; // ou noone, se preferir
	    }
	}

	// atualizar datacore: in_tower e tirar dos braços do player
	with (_c) {
	    in_tower = tower_inst;
		if (variable_instance_exists(tower_inst, "node_label")) {
			in_tower_node_label = tower_inst.node_label;
		} else {
			in_tower_tower_id = tower_inst.tower_id;
		}
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
	show_debug_message("place_datacore_on_tower: datacore id " + string(_c) + " colocado em tower id " + string(tower_inst));
	
	recompute_energy();
	return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function place_datacore_on_tower2(dc_inst, tower_inst) {

	if (!instance_exists(tower_inst)) return false;

	// opcional: checar tipo do objeto carregado (garantir que é um datacore)
	if (dc_inst.object_index != obj_datacore) return false 

	// tower deve ter campo datacore_inst
	if (!variable_instance_exists(tower_inst, "datacore_inst")) return false;

	// se já ocupado, falha (policy: não substitui automaticamente)
	if (tower_inst.datacore_inst != noone) {
	    //if (is_undefined(snd_error) == false) audio_play_sound(snd_error,1,false);
	    return false;
	}

	// encaixa: atualiza campos da torre e do datacore
	with (tower_inst) {
	    datacore_inst = dc_inst;
	    occupied = true;
		
		if (variable_instance_exists(dc_inst, "payload")) {
	        payload = string(dc_inst.payload);
	    } else {
	        payload = ""; // ou noone, se preferir
	    }
	}

	// atualizar datacore: in_tower e tirar dos braços do player
	with (dc_inst) {
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
	
	// feedback
	//if (is_undefined(snd_place) == false) audio_play_sound(snd_place,1,false);
	show_debug_message("place_datacore_on_tower: datacore id " + string(dc_inst) + " colocado em tower id " + string(tower_inst));
	
	recompute_energy();
	return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// Retira o datacore da torre (se houver) e coloca no player como carrying.
/// Retorna true se sucesso, false caso contrário.
function take_datacore_from_tower(tower_inst, player_inst) {

	if (!instance_exists(tower_inst)) return false;
	if (!instance_exists(player_inst)) return false;

	// torre deve ter datacore
	if (!variable_instance_exists(tower_inst, "datacore_inst")) return false;
	if (tower_inst.datacore_inst == noone) return false;

	// player não pode já carregar algo
	if (variable_instance_exists(player_inst, "carrying") && player_inst.carrying != noone) return false;

	// pegar referência do datacore
	var _c = tower_inst.datacore_inst;
	
	if (!instance_exists(_c)) {
	    // dado inconsistente — limpa a torre
	    with (tower_inst) {
	        datacore_inst = noone;
	        occupied = false;
	    }
	    return false;
	}
	
	if (_c.object_index != obj_datacore) return false 

	// remover do tower
	with (tower_inst) {
	    datacore_inst = noone;
	    occupied = false;
		if (variable_instance_exists(self, "payload")) payload = "";
	}

	// atualizar datacore: tirar de in_tower e marcar como carregado
	with (_c) {
	    in_tower = noone;
	    carried_by = player_inst; // set para a instância do player
	}

	// atualizar player: set carrying, set carry_side baseado na face atual
	player_inst.carrying = _c;
	player_inst.carry_side = player_inst.face;

	// posiciona datacore na posição de attach do player imediatamente
	if (is_undefined(player_inst.carry_offset)) player_inst.carry_offset = 20;
	var _attach = get_attach_pos(player_inst.x, player_inst.y, player_inst.carry_side, player_inst.carry_offset);
	with (_c) {
	    x = _attach.x;
	    y = _attach.y;
	}

	// feedback
	//if (!is_undefined(snd_pickup)) audio_play_sound(snd_pickup, 1, false);
	show_debug_message("take_datacore_from_tower: player carregando datacore id " + string(_c));

	recompute_energy();
	return true;
}


// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function get_slot_payload(slot_inst) {
	if (!instance_exists(slot_inst)) return noone;
	if (variable_instance_exists(slot_inst, "payload") && slot_inst.payload != noone) {
	    return string(slot_inst.payload);
	}
	// fallback: se estiver referenciando um datacore, pegar payload do datacore
	if (variable_instance_exists(slot_inst, "datacore_inst") && slot_inst.datacore_inst != noone && instance_exists(slot_inst.datacore_inst)) {
	    var core = slot_inst.datacore_inst;
	    if (variable_instance_exists(core, "payload")) return string(core.payload);
	}
	return noone;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// retorna instância do obj_data_slot ou noone
function find_slot_by_label(label) {
	var n = instance_number(obj_data_slot);
	for (var i = 0; i < n; ++i) {
	    var s = instance_find(obj_data_slot, i);
	    if (!instance_exists(s)) continue;
	    if (variable_instance_exists(s, "node_label") && string(s.node_label) == string(label)) return s;
	}
	return noone;
}

/// retorna instância do obj_array_element ou noone
function find_element_by_tower_id(tower_id) {
	var n = instance_number(obj_array_element);
	for (var i = 0; i < n; ++i) {
	    var s = instance_find(obj_array_element, i);
	    if (!instance_exists(s)) continue;
	    if (variable_instance_exists(s, "tower_id") && string(s.tower_id) == string(tower_id)) return s;
	}
	return noone;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// retorna instância do obj_datacore ou noone
function find_datacore_by_obj_id(obj_id) {
	var n = instance_number(obj_datacore);
	for (var i = 0; i < n; ++i) {
	    var d = instance_find(obj_datacore, i);
	    if (!instance_exists(d)) continue;
	    if (variable_instance_exists(d, "obj_id") && string(d.obj_id) == string(obj_id)) return d;
	}
	return noone;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// @desc  find_array_element(array_id, index) -> inst_id or noone
/// @param {any} array_id Description
/// @param {any} index Description
function find_array_element(array_id, index) {
    if (is_undefined(array_id)) return noone;
    with(obj_array_element) {
        if (variable_instance_exists(id, "array_id") && variable_instance_exists(id, "index")) {
            if (string(self.array_id) == string(array_id) && real(self.index) == real(index)) {
                return id;
            }
        }
    }
    return noone;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>



// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>