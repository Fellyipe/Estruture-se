// exposições globais
global.save_manager = id;
global.save_version = "1.0";
global.save_slots = 3;

// Estruturas internas (usar structs/arrays para json_encode direto)
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
		hp: 100, 
		score: 0 
	},
    inventory: [],
    rooms: {},         // mapa room_name -> { puzzles: { id: {state:..., ...} } }
    checkpoints: { 
		has: false, 
		room: "", 
		x:0, 
		y:0 
	}
};

// Últimos slots para debug
last_save_slot = -1;
last_load_slot = -1;



// !!!!! FUNÇÕES !!!!!


function save_manager_set_player(x,y,hp,score) {
	save_state.player.x = x;
	save_state.player.y = y;
	save_state.player.hp = hp;
	save_state.player.score = score;
	save_state.player.room_index = room;
	save_state.player.room_name = room_get_name(room);
}

function save_manager_add_item(item_id) {
	array_push(save_state.inventory, item_id);
}

function save_manager_set_puzzle_state(room_name, puzzle_id, map_state) {
	if (!variable_struct_exists(save_state.rooms, room_name)) {
	    save_state.rooms[room_name] = { puzzles: {} };
	}
	save_state.rooms[room_name].puzzles[puzzle_id] = map_state; // map_state = {state:"aberta", progress:2}
}

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

    // atualiza player imediato se existir instância
    //if (instance_exists(obj_player)) {
    //    with (obj_player) {
    //        other.save_state.player.x = x;
    //        other.save_state.player.y = y;
    //        other.save_state.player.hp = hp;
    //        other.save_state.player.score = score;
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
    show_message("Jogo salvo (JSON) no slot " + string(slot) + ".");
}








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

    // aplicar player: se room diferente, usar pending_load e room_goto
    var prow = save_state.player;
    if (variable_struct_exists(prow, "room_index") && prow.room_index != room) {
        global.pending_load = { type: "slot_load", slot: slot };
        room_goto(prow.room_index);
        // o Room Start do manager aplicará player/puzzles depois que a room for carregada
    } else {
        // mesma room: aplica direto
        //if (instance_exists(obj_player)) {
        //    with (obj_player) {
        //        if (variable_struct_exists(prow, "x")) x = prow.x;
        //        if (variable_struct_exists(prow, "y")) y = prow.y;
        //        if (variable_struct_exists(prow, "hp")) hp = prow.hp;
        //        if (variable_struct_exists(prow, "score")) score = prow.score;
        //    }
        //} else {
        //    // guarda em globals para uso na criação do player
        //    if (variable_struct_exists(prow, "x")) global.player_x = prow.x;
        //    if (variable_struct_exists(prow, "y")) global.player_y = prow.y;
        //    if (variable_struct_exists(prow, "hp")) global.player_hp = prow.hp;
        //    if (variable_struct_exists(prow, "score")) global.player_score = prow.score;
        //}

        // aplicar inventário (sobrescreve o array)
        if (variable_struct_exists(save_state, "inventory")) {
            // sobrescreve internal inventory array
            // se você quer mapear para ds_list do jogo, faça aqui; por simplicidade armazenamos no save_state.inventory
        }
        // aplicar puzzles da sala atual
        // Room Start codigo também aplica, mas podemos aplicar agora se preferir
    }

    last_load_slot = slot;
    show_message("Save carregado do slot " + string(slot) + ".");
    return true;
}


