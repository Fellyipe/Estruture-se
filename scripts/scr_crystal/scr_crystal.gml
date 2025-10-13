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
	    //if (is_undefined(snd_error) == false) audio_play_sound(snd_error,1,false);
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
	
	recompute_energy();
	return true;
}


function place_crystal_on_tower2(c_inst, tower_inst) {

	if (!instance_exists(tower_inst)) return false;

	// tower deve ter campo crystal_inst
	if (!variable_instance_exists(tower_inst, "crystal_inst")) return false;

	// se já ocupado, falha (policy: não substitui automaticamente)
	if (tower_inst.crystal_inst != noone) {
	    //if (is_undefined(snd_error) == false) audio_play_sound(snd_error,1,false);
	    return false;
	}

	// encaixa: atualiza campos da torre e do cristal
	with (tower_inst) {
	    crystal_inst = c_inst;
	    occupied = true;
	}

	// atualizar cristal: in_tower e tirar dos braços do player
	with (c_inst) {
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
	show_debug_message("place_crystal_on_tower: cristal id " + string(c_inst) + " colocado em tower id " + string(tower_inst));
	
	recompute_energy();
	return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>




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

	recompute_energy();
	return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function point_to_tower(my_address) {
	find_pointer_by_address(my_address)
	with (obj_pointer) {
		if(address == my_address) {
			incoming_count = 1;	
		}
	}
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function despoint_to_tower(my_address) {
	with (obj_pointer) {
		if(address == my_address) {
			incoming_count = 0;	
		}
	}
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// retorna id do pointer ou noone com base no address
function find_pointer_by_address(address) {
	var _n = instance_number(obj_pointer);
	for (var i = 0; i < _n; ++i) {
	    var inst = instance_find(obj_pointer, i);
	    if (instance_exists(inst)) {
	        if (string(inst.address) == address) {
	            return inst;
	        }
	    }
	}
	return noone;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// return: retorna target inst ou noone
function set_pointer_target_by_address(from_id, address) {

	if (!instance_exists(from_id)) return noone;

	var to_id = find_pointer_by_address(address);

	if (address == "null") {
		// from_id.active_emitter = false;	
		to_id = noone;
	}

	// opcional: decremento do contador antigo (se você mantiver incoming_count histórico)
	//if (from_id.target_inst != noone && instance_exists(from_id.target_inst)) {
	//    with (from_id.target_inst) {
	//        if (variable_instance_exists(self, "incoming_count")) incoming_count = max(0, incoming_count - 1);
	//    }
	//}

	// atualiza target
	from_id.target_inst = to_id;

	// opcional: incrementar incoming_count histórico
	//if (variable_instance_exists(to_id, "incoming_count")) {
	//    with (to_id) incoming_count += 1;
	//}

	// recomputa a rede (BFS)
	recompute_energy();

	return to_id;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>


/// Modelo A: node energizado se (crystal_inst != noone) AND incoming_active_count > 0
/// Heads com crystal inst são fontes iniciais.
function recompute_energy() {

	/// Reseta todos os ponteiros (obj_pointer)
	var _n = instance_number(obj_pointer);
	for (var i = 0; i < _n; ++i) {
	    var p = instance_find(obj_pointer, i);
	    if (!instance_exists(p)) continue;
	    with (p) {
	        // inicializa caso não exista
	        if (!variable_instance_exists(self, "incoming_active_count")) incoming_active_count = 0;
	        if (!variable_instance_exists(self, "active_emitter")) active_emitter = false;
	        if (!variable_instance_exists(self, "energized")) energized = false;
	        if (!variable_instance_exists(self, "emitter_queued")) emitter_queued = false;

	        incoming_active_count = 0;
	        active_emitter = false;
	        energized = false;
	        emitter_queued = false;
	    }
	}


	/// Cria fila e enfileira heads que têm cristal
	var q = ds_queue_create();
	for (var j = 0; j < _n; ++j) {
	    var p2 = instance_find(obj_pointer, j);
	    if (!instance_exists(p2)) continue;
		
	    // se for head e tiver cristal, marca energized e enfileira
	    if (variable_instance_exists(p2, "is_head") && p2.is_head) {
	        if (variable_instance_exists(p2, "crystal_inst") && p2.crystal_inst != noone) {
	            with (p2) {
	                energized = true;
	                emitter_queued = true;
	            }
	            ds_queue_enqueue(q, p2);
	        }
	    }
	}

	/// Propaga pela fila
	/// Só está nessa lista quem é energized
	var MAX_STEPS = 10000; // segurança
	var steps = 0;
	while (!ds_queue_empty(q) && steps < MAX_STEPS) {
	    var cur = ds_queue_dequeue(q);
	    steps += 1;
	    if (!instance_exists(cur)) continue;

	    // marca que cur está emitindo
	    with (cur) {
			if(value == "null") active_emitter = false else active_emitter = true;
	    }

	    // obtém target e processa
	    var tgt = noone;
	    if (variable_instance_exists(cur, "target_inst")) tgt = cur.target_inst;
	    if (tgt == noone || !instance_exists(tgt)) continue;

	    // incrementa contador de entradas ativas no target
	    with (tgt) {
	        if (!variable_instance_exists(self, "incoming_active_count")) incoming_active_count = 0;
	        incoming_active_count += 1;

	        // Só vira energized se tiver cristal encaixado
	        if (variable_instance_exists(self, "crystal_inst") && crystal_inst != noone) {
	            if (!energized) energized = true;
	            // se ainda não for colocado na fila para emitir, coloque
	            if (!emitter_queued) {
	                emitter_queued = true;
	                ds_queue_enqueue(q, id);
	            }
	        }
	        // se não tem cristal, não vira energized, mas incoming_active_count foi incrementado
	    }
	}
	ds_queue_destroy(q);

	/// 4) pós-processamento: overloads (simples)
	for (var k = 0; k < _n; ++k) {
	    var p3 = instance_find(obj_pointer, k);
	    if (!instance_exists(p3)) continue;
	    with (p3) {
	        if (variable_instance_exists(self, "max_incoming") && max_incoming > 0) {
	            if (incoming_active_count > max_incoming) {
	                overloaded = true;
	                overload_cooldown = overload_cooldown_max;
	            }
	        }
	    }
	}

	// Fim: agora cada pointer tem incoming_active_count e energized atualizados.
	//var ctrl = instance_find(obj_controller_puzzle_base, 0);
	
	//if(ctrl != noone) {
	//	ctrl.solution = check_sequence(ctrl.head_pointer, ctrl.solution_list);	
	//	if (ctrl.solution && is_callable(ctrl.on_complete)) {
    //        ctrl.on_complete();
    //    }
	//}
	with(obj_controller_puzzle_base) {
		var was_solved = solved;
		solved = check_sequence(head_pointer, solution_list, owns_solution_maps);	
		if (solved && !was_solved && is_callable(on_complete)) {
	        on_complete();
	    } else if (!solved && was_solved && is_callable(on_descomplete)) {
			on_descomplete();
		}
	}
	
		
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// retorna instância do obj_datacore ou noone
function find_crystal_by_obj_id(obj_id) {
	var n = instance_number(obj_crystal);
	for (var i = 0; i < n; ++i) {
	    var c = instance_find(obj_crystal, i);
	    if (!instance_exists(c)) continue;
	    if (variable_instance_exists(c, "obj_id") && string(c.obj_id) == string(obj_id)) return c;
	}
	return noone;
}