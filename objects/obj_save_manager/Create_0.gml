// exposições globais
global.save_manager = id;
global.save_version = "1.0";
global.save_slots = 3;

room_spawn_coords = {};
room_spawn_coords[$ "rm_lobby"] = { x: 544, y: 70, face: DOWN };
room_spawn_coords[$ "rm_puzzle_2_1"] = { x: 48, y: 200, face: RIGHT };
room_spawn_coords[$ "rm_puzzle_2_2"] = { x: 48, y: 200, face: RIGHT };

// Estruturas internas (usar structs/arrays para json_encode direto)
if (!variable_global_exists("pending_save_state")) {
	save_state = {
	    meta: { 
			version: global.save_version, 
			slot: -1, 
			timestamp: "" 
		},
	    player: { 
			room_index: room, 
			room_name: room_get_name(room), 
			x: 0, 
			y: 0, 
		},
	    inventory: [],
	    rooms: {},         // mapa room_name -> { puzzles: { id: {state:..., ...} } }
	    rooms_initial: {},
		rooms_checkpoint: {},
		checkpoints: { 
			has: false, 
			room: "", 
			x:0, 
			y:0 
		},
		concepts_unlocked: []
	};
} else {
	save_state = {};
}
// Últimos slots para debug
last_save_slot = -1;
last_load_slot = -1;

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function save_manager_set_player(x,y,hp,score) {
	save_state.player.x = x;
	save_state.player.y = y;
	save_state.player.room_index = room;
	save_state.player.room_name = room_get_name(room);
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function save_manager_add_item(item_id) {
	array_push(save_state.inventory, item_id);
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function save_manager_set_puzzle_state(room_name, puzzle_id, map_state) {
	//if (!variable_struct_exists(save_state.rooms, room_name)) {
	    save_state.rooms[$ room_name] = { puzzles: {} };
	//}
	save_state.rooms[$ room_name].puzzles[puzzle_id] = map_state; // map_state = {state:"aberta", progress:2}
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// @function save_slot(slot)
/// @description Salva o estado atual do jogo em um arquivo JSON no slot indicado.
/// @param {real} slot - Número do slot de save (ex: 1, 2, 3).
/// - Faz backup do arquivo anterior usando `scr_make_backup_file`.
/// - Serializa `save_state` para JSON usando `json_stringify`.
/// - Escreve o JSON no arquivo usando `scr_write_text_atomic`.
/// obj_save_manager.save_slot(slot)  -- método, invoque como: with(global.save_manager) save_slot(1);
function save_slot(slot) {
    var fname = "save_slot" + string(slot) + ".json";
    // backup
    make_backup_file(fname);
    // atualiza meta e timestamp
    save_state.meta.version = global.save_version;
    save_state.meta.slot = slot;
    save_state.meta.timestamp = date_current_datetime(); // _timestamp_now();

	save_state.concepts_unlocked = variable_clone(global.unlocked_concepts);


    // atualiza player imediato se existir instância
    //if (instance_exists(obj_player)) {
    //    with (obj_player) {
    //        other.save_state.player.x = x;
    //        other.save_state.player.y = y;
    //        other.save_state.player.room_index = room;
    //        if (function_exists(room_get_name)) other.save_state.player.room_name = room_get_name(room);
    //        else other.save_state.player.room_name = string(room);
    //    }
    //}

    // stringify (pretty = false para menor arquivo; true para debug)
    var json_text = json_stringify(save_state, true);

    // escrever de forma atômica
    write_text_atomic(fname, json_text);

    last_save_slot = slot;
    //show_message("Jogo salvo (JSON) no slot " + string(slot) + ".");
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// @function load_slot(slot)
/// @description Carrega os dados de jogo de um arquivo JSON para `save_state`.
/// @param {real} slot - Número do slot de save.
/// - Lê o arquivo JSON do slot indicado.
/// - Converte para struct usando `json_parse`.
/// - Atualiza `save_state` com os dados carregados.
/// obj_save_manager.load_slot(slot) -> true/false
function load_slot(slot) {
    var fname = "save_slot" + string(slot) + ".json";
    if (!file_exists(fname)) {
        show_message("Nenhum save no slot " + string(slot) + ".");
        return false;
    }

    var content = read_text_file(fname);
    if (string_length(content) == 0) {
        show_message("Save vazio / corrompido.");
        return false;
    }

    // parse JSON para struct
    var loaded = json_parse(content);
	
	// após validar `loaded`:
	global.pending_save_state = loaded;     // guarda em global para sobreviver ao room_goto
	global.pending_load = { type: "slot_load", slot: slot };
	room_goto(loaded.player.room_index);

	
    if (!is_struct(loaded) || !variable_struct_exists(loaded, "meta")) {
        show_message("Save inválido ou corrompido.");
        return false;
    }

    // versão - checagem simples
    if (loaded.meta.version != global.save_version) {
        // opcional: chamar rotinas de migração
        show_message("Atenção: versão do save (" + string(loaded.meta.version) + ") diferente da atual (" + global.save_version + ").");
        // você pode prosseguir ou abortar; aqui seguimos
    }

    // guarda no estado atual
    save_state = loaded;
	
	/// Garantir que rooms_checkpoint exista como struct
	if (!variable_struct_exists(save_state, "rooms_checkpoint") || !is_struct(save_state.rooms_checkpoint)) {
	    save_state.rooms_checkpoint = {};
	}
	
	save_state.rooms_checkpoint = variable_clone(save_state.rooms);

    // aplicar player: se room diferente, usar pending_load e room_goto
    var prow = save_state.player;
    if (variable_struct_exists(prow, "room_index") && prow.room_index != room) {
        global.pending_load = { type: "slot_load", slot: slot };
        room_goto(prow.room_index);
		
		if (variable_struct_exists(room_spawn_coords, prow.room_name)) {
			var rc = room_spawn_coords[$ prow.room_name];
		    if (instance_exists(obj_player)) { with(obj_player) { x = rc.x; y = rc.y; face = rc.face; } }
		}
        // o Room Start do manager aplicará player/puzzles depois que a room for carregada
    } else {
        // mesma room: aplica direto
        //if (instance_exists(obj_player)) {
        //    with (obj_player) {
        //        if (variable_struct_exists(prow, "x")) x = prow.x;
        //        if (variable_struct_exists(prow, "y")) y = prow.y;
        //    }
        //} else {
        //    // guarda em globals para uso na criação do player
        //    if (variable_struct_exists(prow, "x")) global.player_x = prow.x;
        //    if (variable_struct_exists(prow, "y")) global.player_y = prow.y;
        //}

        // aplicar puzzles da sala atual
        // Room Start codigo também aplica, mas podemos aplicar agora se preferir
    }

    last_load_slot = slot;
    //show_message("Save carregado do slot " + string(slot) + ".");
	
	concepts_init();
	
    return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// save_room_state(room_name)
function save_room_state(room_name) {
    if (!is_string(room_name)) room_name = room_get_name(room);

    var room_rec = {};
    room_rec.pointers = []; // array de structs
    room_rec.slots    = [];
    room_rec.crystals = [];
    room_rec.datacores = [];
    room_rec.meta = { saved_at: date_current_datetime() };

    // pointers: iterar instâncias de obj_pointer e extrair campos relevantes
    var pn = instance_number(obj_pointer);
    for (var i = 0; i < pn; ++i) {
        var p = instance_find(obj_pointer, i);
        if (!instance_exists(p)) continue;
        var rec = {
            address: (variable_instance_exists(p, "address") ? p.address : ""),
            target_label: "",
            is_head: (variable_instance_exists(p, "is_head") ? p.is_head : false),
            head_locked: (variable_instance_exists(p, "head_locked") ? p.head_locked : false)
        };
        // target as label/address (if available)
        if (variable_instance_exists(p, "target_inst") && p.target_inst != noone && instance_exists(p.target_inst)) {
            if (variable_instance_exists(p.target_inst, "address")) rec.target_label = p.target_inst.address;
            else if (variable_instance_exists(p.target_inst, "node_label")) rec.target_label = p.target_inst.node_label;
        }
        array_push(room_rec.pointers, rec);
    }

    // slots: payload, datacore ref (label)
    var sn = instance_number(obj_data_slot);
    for (var j = 0; j < sn; ++j) {
        var s = instance_find(obj_data_slot, j);
        if (!instance_exists(s)) continue;
        var srec = {
            node_label: (variable_instance_exists(s, "node_label") ? s.node_label : ""),
            payload: (variable_instance_exists(s, "payload") ? s.payload : null),
            occupied: (variable_instance_exists(s, "datacore_inst") && s.datacore_inst != noone),
            datacore_label: ""
        };
        if (srec.occupied) {
            var core = s.datacore_inst;
            if (instance_exists(core) && variable_instance_exists(core, "id_label")) {
                srec.datacore_label = core.id_label;
            }
        }
        array_push(room_rec.slots, srec);
    }

    // datacores (standalone not attached) - useful if you spawn some loose
    var cn = instance_number(obj_datacore);
    for (var k = 0; k < cn; ++k) {
        var c = instance_find(obj_datacore, k);
        if (!instance_exists(c)) continue;
        var crec = {
            id_label: (variable_instance_exists(c, "id_label") ? c.id_label : ""),
            payload: (variable_instance_exists(c, "payload") ? c.payload : ""),
            in_slot_label: (variable_instance_exists(c, "in_tower") && c.in_tower != noone && variable_instance_exists(c.in_tower, "node_label") ? c.in_tower.node_label : "")
        };
        array_push(room_rec.datacores, crec);
    }
	
    if (!variable_struct_exists(save_state, "rooms")) save_state.rooms = {};
    save_state.rooms[$ room_name] = room_rec;

	
    // optional: recompute meta
    save_state.meta.last_room_saved = room_name;
    save_state.meta.last_saved_at = date_current_datetime();

    return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// apply_room_state(room_name)
function apply_room_state(room_name) {
    if (!variable_struct_exists(save_state, "rooms")) return false;
    if (!variable_struct_exists(save_state.rooms, room_name)) return false;

    var room_rec = save_state.rooms[$ room_name];

    // 1) Apply pointers (targets and flags)
    var pcount = array_length(room_rec.pointers);
    for (var i = 0; i < pcount; ++i) {
        var prec = room_rec.pointers[i];
        // procurar pointer por address (helper do teu projeto)
        var p = noone;
        if (is_undefined(find_pointer_by_address) == false) {
            p = find_pointer_by_address(prec.address);
        } else {
            // fallback: procurar por address entre obj_pointer
            var pn = instance_number(obj_pointer);
            for (var ii = 0; ii < pn; ++ii) {
                var pp = instance_find(obj_pointer, ii);
                if (!instance_exists(pp)) continue;
                if (variable_instance_exists(pp, "address") && string(pp.address) == string(prec.address)) { p = pp; break; }
            }
        }
        if (!instance_exists(p)) continue;

        // flags
        if (variable_instance_exists(p, "is_head")) p.is_head = (prec.is_head == true);
        if (variable_instance_exists(p, "head_locked")) p.head_locked = (prec.head_locked == true);

        // set target_inst by label/address
        if (prec.target_label != "" && prec.target_label != noone) {
            var targ = noone;
            if (!is_undefined(find_pointer_by_address)) targ = find_pointer_by_address(prec.target_label);
            if (targ == noone) {
                // fallback: try label match
                var pn2 = instance_number(obj_pointer);
                for (var jj = 0; jj < pn2; ++jj) {
                    var pp2 = instance_find(obj_pointer, jj);
                    if (!instance_exists(pp2)) continue;
                    if (variable_instance_exists(pp2, "address") && string(pp2.address) == string(prec.target_label)) { targ = pp2; break; }
                }
            }
            p.target_inst = (instance_exists(targ) ? targ : noone);
        } else {
            p.target_inst = noone;
        }
    }

    // 2) Apply slots (payload and attach datacores)
    var scount = array_length(room_rec.slots);
    for (var sidx = 0; sidx < scount; ++sidx) {
        var srec = room_rec.slots[sidx];
        var slot = noone;
        if (!is_undefined(find_slot_by_label)) slot = find_slot_by_label(srec.node_label);
        else {
            // fallback: linear search
            var ns = instance_number(obj_data_slot);
            for (var z = 0; z < ns; ++z) {
                var ss = instance_find(obj_data_slot, z);
                if (!instance_exists(ss)) continue;
                if (variable_instance_exists(ss, "node_label") && string(ss.node_label) == string(srec.node_label)) { slot = ss; break; }
            }
        }
        if (!instance_exists(slot)) continue;

        // set payload cache
        slot.payload = srec.payload;

        // attach datacore if label present
        if (srec.occupied && string(srec.datacore_label) != "") {
            var core = noone;
            if (!is_undefined(find_datacore_by_obj_id)) core = find_datacore_by_obj_id(srec.datacore_label);
            // fallback search by id_label
            if (core == noone) {
                var cn = instance_number(obj_datacore);
                for (var cii = 0; cii < cn; ++cii) {
                    var cc = instance_find(obj_datacore, cii);
                    if (!instance_exists(cc)) continue;
                    if (variable_instance_exists(cc, "id_label") && string(cc.id_label) == string(srec.datacore_label)) { core = cc; break; }
                }
            }
            if (core != noone && instance_exists(core)) {
                with (slot) {
                    datacore_inst = core;
                    occupied = true;
                    payload = (variable_instance_exists(core, "payload") ? core.payload : payload);
                }
                with (core) {
                    in_tower = slot;
                    x = slot.slot_x; y = slot.slot_y;
                }
            } else {
                // se não achou core, spawn one com payload (helper abaixo)
                attach_datacore_to_slot_coreless(slot, srec.payload, srec.datacore_label);
            }
        } else {
            // no datacore attached: ensure datacore_inst cleared
            slot.datacore_inst = noone;
            slot.occupied = false;
            // payload already set
        }
    }

    // 3) datacores list: opcional spawn de datacores soltos
    if (variable_struct_exists(room_rec, "datacores")) {
        var dcount = array_length(room_rec.datacores);
        for (var d = 0; d < dcount; ++d) {
            var drec = room_rec.datacores[d];
            // se já existe um datacore com este id_label, pulamos
            var exists_core = noone;
            if (!is_undefined(find_datacore_by_obj_id)) exists_core = find_datacore_by_obj_id(drec.id_label);
            if (exists_core == noone) {
                // spawn loose datacore at some position - default near origin or slot if specified
                var px = 0, py = 0;
                if (variable_struct_exists(drec, "in_slot_label") && string(drec.in_slot_label) != "") {
                    var sl = (is_undefined(find_slot_by_label) ? noone : find_slot_by_label(drec.in_slot_label));
                    if (sl != noone) { px = sl.slot_x; py = sl.slot_y; }
                } else {
                    px = x; py = y; // fallback center
                }
                var newcore = instance_create_layer(px, py, "Instances", obj_datacore);
                newcore.payload = drec.payload;
                if (variable_struct_exists(drec, "id_label")) newcore.id_label = drec.id_label;
            }
        }
    }

    // 4) por fim, recompute energy
    if (is_undefined(recompute_energy) == false) recompute_energy();

    return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// save_room_state_simple(room_name) -> struct room_rec (e grava em save_state.rooms[room_name])
function save_room_state_simple(room_name) {
    if (!is_string(room_name)) room_name = room_get_name(room);

    // 1) garantir player não cargando datacore/crystal
    ensure_player_not_carrying_for_save();

    var room_rec = {};
    room_rec.pointers = [];
    room_rec.slots = [];
    room_rec.datacores = [];
    room_rec.crystals = [];
    room_rec.player = {};

    // pointers
    var pn = instance_number(obj_pointer);
    for (var i = 0; i < pn; ++i) {
        var p = instance_find(obj_pointer, i);
        if (!instance_exists(p)) continue;
        var pr = {
            address: (variable_instance_exists(p,"address")?p.address:""),
            value: (variable_instance_exists(p,"value")?p.value:""),
        };
        array_push(room_rec.pointers, pr);
    }

    // slots
    var sn = instance_number(obj_data_slot);
    for (var j = 0; j < sn; ++j) {
        var s = instance_find(obj_data_slot, j);
        if (!instance_exists(s)) continue;
        var srec = {
            node_label: (variable_instance_exists(s,"node_label")?s.node_label:""),
//            payload: (variable_instance_exists(s,"payload_cache")?s.payload_cache:null),
//            datacore_obj_id: (variable_instance_exists(s,"datacore_inst") && s.datacore_inst != noone && variable_instance_exists(s.datacore_inst,"obj_id") ? s.datacore_inst.obj_id : ""),
        };
        array_push(room_rec.slots, srec);
    }

    // datacores (all datacores in the room)
    var dn = instance_number(obj_datacore);
    for (var k = 0; k < dn; ++k) {
        var d = instance_find(obj_datacore, k);
        if (!instance_exists(d)) continue;
        var drec = {
            obj_id: (variable_instance_exists(d,"obj_id")?d.obj_id:""),
//            payload: (variable_instance_exists(d,"payload")?d.payload:""),
			in_tower_node_label: (variable_instance_exists(d,"in_tower_node_label")?d.in_tower_node_label:""),
			in_tower_tower_id: (variable_instance_exists(d,"in_tower_tower_id")?d.in_tower_tower_id:""),
            x: d.x, y: d.y
        };
        array_push(room_rec.datacores, drec);
    }

    // crystals
    var cn = instance_number(obj_crystal);
    for (var m = 0; m < cn; ++m) {
        var c = instance_find(obj_crystal, m);
        if (!instance_exists(c)) continue;
        var crec = {
            obj_id: (variable_instance_exists(c,"obj_id")?c.obj_id:""),
            in_tower_address: (variable_instance_exists(c,"in_tower_address")?c.in_tower_address:""),
            x: c.x, y: c.y
        };
        array_push(room_rec.crystals, crec);
    }

    // player
    if (instance_exists(obj_player)) {
        with (obj_player) {
            room_rec.player = { x: x, y: y, room_name: room_get_name(room) };
        }
    }

    // write into global save structure (ensure it's a struct)
    if (!variable_struct_exists(save_state, "rooms") || !is_struct(save_state.rooms)) save_state.rooms = {};
    save_state.rooms[$ room_name] = room_rec;

    return room_rec;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// apply_room_state_simple(room_name)
function apply_room_state_simple(room_name, rooms_struct = save_state.rooms) {
    //if (!variable_struct_exists(save_state, "rooms")) return false;
    //if (!variable_struct_exists(save_state.rooms, room_name)) return false;

    var rec = rooms_struct[$ room_name];

    // 1) spawn/ensure datacores exist with given obj_id
    if (array_length(rec.datacores) > 0) {
        for (var i = 0; i < array_length(rec.datacores); ++i) {
            var drec = rec.datacores[i];
            var core = find_datacore_by_obj_id(drec.obj_id);
            if (core == noone) {
                // spawn new datacore at x,y
                //var px = drec.x != undefined ? drec.x : x;
                //var py = drec.y != undefined ? drec.y : y;
                //core = instance_create_layer(px, py, "Instances", obj_datacore);
                //core.obj_id = drec.obj_id;
                //core.payload = drec.payload;
            } else {
                // update payload
                //if (variable_instance_exists(core, "payload")) core.payload = drec.payload;
                core.x = drec.x; core.y = drec.y; core.in_tower_node_label = drec.in_tower_node_label; core.in_tower_tower_id = core.in_tower_tower_id;
				
				
				if core.in_tower_node_label != "" {
					var t_inst = find_slot_by_label(core.in_tower_node_label)
					if t_inst != noone place_datacore_on_tower2(core, t_inst)
				}
				if core.in_tower_tower_id != "" {
					var t_inst = find_element_by_tower_id(core.in_tower_tower_id)
					if t_inst != noone place_datacore_on_tower2(core, t_inst)
				}
            }
        }
    }

    // 2) spawn/ensure crystals exist
    if (array_length(rec.crystals) > 0) {
        for (var i = 0; i < array_length(rec.crystals); ++i) {
            var crec = rec.crystals[i];
            var cinst = find_crystal_by_obj_id(crec.obj_id);
            if (cinst == noone) {
                //var px2 = crec.x != undefined ? crec.x : x;
                //var py2 = crec.y != undefined ? crec.y : y;
                //cinst = instance_create_layer(px2, py2, "Instances", obj_crystal);
                //cinst.obj_id = crec.obj_id;
            } else {
                cinst.x = crec.x; cinst.y = crec.y; cinst.in_tower_address = crec.in_tower_address;
				
				if cinst.in_tower_address != "" {
					var t_inst = find_pointer_by_address(cinst.in_tower_address )
					if t_inst != noone place_crystal_on_tower2(cinst, t_inst)
				}



            }
        }
    }

    // 3) attach datacores to slots
    if (array_length(rec.slots) > 0) {
        for (var i = 0; i < array_length(rec.slots); ++i) {
            var srec = rec.slots[i];
            var slot = find_slot_by_label(srec.node_label);
            if (slot == noone) {
                show_debug_message("apply_room_state_simple: slot '" + srec.node_label + "' não encontrado");
                continue;
            }
            // keep payload_cache
            //slot.payload_cache = srec.payload;

            //// attach datacore if specified
            //if (srec.datacore_obj_id != "" && srec.datacore_obj_id != undefined) {
            //    var core2 = find_datacore_by_obj_id(srec.datacore_obj_id);
            //    if (core2 != noone) {
            //        // prefer using your helper function if exists
            //        if (!is_undefined(place_datacore_on_tower2)) {
            //            place_datacore_on_tower2(core2, slot); // signature you have to match; or adapt
            //        } else {
            //            // fallback: manual attach
            //            with (slot) {
            //                datacore_inst = core2;
            //                occupied = true;
            //                payload_cache = core2.payload;
            //            }
            //            with (core2) {
            //                in_tower = slot;
            //                x = slot.slot_x; y = slot.slot_y;
            //            }
            //        }
            //    } else {
            //        // spawn a datacore if not found
            //        //attach_datacore_to_slot_coreless(slot, srec.payload, srec.datacore_obj_id);
            //    }
            //} else {
            //    // ensure cleared state if no datacore
            //    slot.datacore_inst = noone;
            //    slot.occupied = false;
            //}
        }
    }

    // 4) set pointers values (addresses exist as instances already)
    if (array_length(rec.pointers) > 0) {
        for (var i = 0; i < array_length(rec.pointers); ++i) {
            var prec = rec.pointers[i];
            var pinst = find_pointer_by_address(prec.address);
            if (pinst != noone) {
                pinst.value = prec.value;
                // optionally reposition
                //pinst.x = prec.x; pinst.y = prec.y;
            }
        }
    }

    // 5) attach crystals to pointers
    //if (array_length(rec.crystals) > 0) {
    //    for (var i = 0; i < array_length(rec.crystals); ++i) {
    //        var crec = rec.crystals[i];
    //        var cinst = find_crystal_by_obj_id(crec.obj_id);
    //        if (cinst == noone) continue;
    //        if (crec.in_tower_address != "" && crec.in_tower_address != undefined) {
    //            var tgt = find_pointer_by_address(crec.in_tower_address);
    //            if (tgt != noone) {
    //                if (!is_undefined(place_crystal_on_tower2)) {
    //                    place_crystal_on_tower2(cinst, tgt); // verify function sig
    //                } else {
    //                    with (tgt) { crystal_inst = cinst; occupied = true; }
    //                    with (cinst) { in_tower = tgt; x = tgt.slot_x; y = tgt.slot_y; }
    //                }
    //            }
    //        } else {
    //            // free crystal: position
    //            cinst.x = crec.x; cinst.y = crec.y;
    //        }
    //    }
    //}

    // 6) position player
    //if (variable_struct_exists(rec,"player") && instance_exists(obj_player)) {
    //    with (obj_player) { x = rec.player.x; y = rec.player.y; }
    //}

    // 7) recompute energy to re-evaluate energized flags
    if (!is_undefined(recompute_energy)) recompute_energy();

    return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// ao ativar checkpoint
function on_checkpoint_activate() {
    var rn = room_get_name(room);
    // garante drop se player estiver carregando
    ensure_player_not_carrying_for_save();

    // salva struct em memória
    var cp = save_room_state_simple(rn); // retorna room_rec
    if (!variable_struct_exists(save_state, "rooms_checkpoint")) save_state.rooms_checkpoint = {};
    save_state.rooms_checkpoint[$ rn] = cp;

    // opcional: persistir em disco (auto-save)
    //var AUTO_SLOT = 99; // exemplo: slot 99 é auto-save
    //with (global.save_manager) {
    //    save_slot(AUTO_SLOT); // isto salva todo save_state em arquivo
    //}

    show_debug_message("Checkpoint salvo.");
}


// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function on_player_death() {
    var rn = room_get_name(room);
    // incrementar contador de mortes
    //if (!variable_struct_exists(save_state, "meta")) save_state.meta = {};
    //if (!variable_struct_exists(save_state.meta, "deaths")) save_state.meta.deaths = 0;
    //save_state.meta.deaths += 1;

    // restaurar checkpoint se existir
    if (variable_struct_exists(save_state, "rooms_checkpoint") && variable_struct_exists(save_state.rooms_checkpoint, rn)) {
        apply_room_state_simple(rn, save_state.rooms_checkpoint);
        // aplicar posição do checkpoint (se salvo)
        var cp = save_state.rooms_checkpoint[$ rn];
        if (variable_struct_exists(cp, "player") && instance_exists(obj_player)) {
			
			if (variable_struct_exists(room_spawn_coords, rn)) {
				var rc = room_spawn_coords[$ rn];
			    if (instance_exists(obj_player)) { with(obj_player) { x = rc.x; y = rc.y; } }
			}
		
            //with (obj_player) { x = cp.player.x; y = cp.player.y; }
        }
        show_message("Você morreu — retornando ao último checkpoint.");
    } else {
        // fallback: initial snapshot
        if (variable_struct_exists(save_state, "rooms_initial") && variable_struct_exists(save_state.rooms_initial, rn)) {
            apply_room_state_simple(rn, save_state.rooms_initial);
            var init = save_state.rooms_initial[$ rn];
            if (variable_struct_exists(init, "player") && instance_exists(obj_player)) {
                
				if (variable_struct_exists(room_spawn_coords, rn)) {
					var rc = room_spawn_coords[$ rn];
				    if (instance_exists(obj_player)) { with(obj_player) { x = rc.x; y = rc.y; } }
				}
				
				//with (obj_player) { x = init.player.x; y = init.player.y; }
            }
            show_message("Você morreu — sala reiniciada do começo.");
        } else {
            // fallback forçado: restart room
            room_restart();
        }
    }

    // recompute energy
    if (!is_undefined(recompute_energy)) recompute_energy();
}


// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function player_request_reset_room() {
    var rn = room_get_name(room);
    if (!variable_struct_exists(save_state, "rooms_initial") || !variable_struct_exists(save_state.rooms_initial, rn)) {
        show_message("Não há ponto inicial salvo para esta sala.");
        return;
    }
    //var ok = show_message_yes_no("Deseja reiniciar a sala? Progresso não salvo será perdido.");
    //if (!ok) return;
    apply_room_state_simple(rn, save_state.rooms_initial);
    // opcional: limpar dirty for this room
    //if (variable_struct_exists(save_state, "dirty_rooms")) save_state.dirty_rooms[$ rn] = false;
    show_message("Sala reiniciada.");
}

