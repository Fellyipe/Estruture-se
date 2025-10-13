/// @desc Retorna o nome do arquivo de salvamento,
/// @desc formatado como "save_slotX.json", onde X é o número do slot.
/// @param {any*} slot  O número do slot de salvamento (ex: 1, 2, 3).=
function save_json_filename(slot) {
	return "save_slot" + string(slot) + ".json";
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// @desc           Salva um arquivo de backup (.bak) do arquivo especificado. 
/// @param {string}  path    O nome do arquivo que será verificado e, se existir, será copiado para um arquivo de backup.
function make_backup_file(path) {
	if (!file_exists(path)) return;

	// tenta copiar; se falhar, cai para fallback
	var ok = file_copy(path, path + ".bak");
	if (ok) return;
	

	/// Fallback: ler linha-a-linha e escrever o .bak
	var fr = file_text_open_read(path);
	var content = "";
	var safety = 0;
	var SAFETY_LIMIT = 200000; // bastante alto para arquivos texto típicos

	while (!file_text_eof(fr) && safety < SAFETY_LIMIT) {
	    var line = file_text_readln(fr);
	    content += line;
	    if (!file_text_eof(fr)) content += "\n";
	    safety += 1;
	}
	file_text_close(fr);

	if (safety >= SAFETY_LIMIT) {
	    show_debug_message("scr_make_backup_file: safety limit atingido ao ler " + path);
	    // aborta sem sobrescrever backup para evitar escrever conteúdo parcial
	    return;
	}

	var bak = path + ".bak";
	var fw = file_text_open_write(bak);
	file_text_write_string(fw, content);
	file_text_close(fw);
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

//function make_backup_file(path) {
	
//	if (file_exists(path)) {
//		var fr = file_text_open_read(path);
//		var cont = "";
//		while (!file_text_eof(fr)) {
//		    cont += file_text_read_string(fr);
//		    if (!file_text_eof(fr)) cont += "\n";
//		}
//	    file_text_close(fr);
//	    var bak = path + ".bak";
//	    var fw = file_text_open_write(bak);
//	    file_text_write_string(fw, cont);
//	    file_text_close(fw);
//	}
//}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// @description Escreve text em arquivo path de forma atômica: escreve tmp -> substitui.
/// @param {string} path Caminho do arquivo destino.
/// @param {string} text Texto a ser escrito.
function write_text_atomic(path, text) {
	
	// 1) escreve tmp
	var tmp = path + ".tmp";
	var fw_tmp = file_text_open_write(tmp);
	file_text_write_string(fw_tmp, text);
	file_text_close(fw_tmp);

	// 2) substitui target diretamente usando 'text' (não reler tmp)
	if (file_exists(path)) {
	    // tenta remover o arquivo antigo (ignora erro)
	    file_delete(path);
	}

	// escreve o alvo com o conteúdo (mesmo texto já disponível)
	var fw = file_text_open_write(path);
	file_text_write_string(fw, text);
	file_text_close(fw);

	// 3) remove tmp
	if (file_exists(tmp)) file_delete(tmp);

	return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

//function write_text_atomic(path, text) {

//	/// 1) escreve tmp
//	var tmp = path + ".tmp";
//	var fw = file_text_open_write(tmp);
//	file_text_write_string(fw, text);
//	file_text_close(fw);

//	/// 2) substituir o arquivo original (remover e escrever com o texto que já temos)
//	if (file_exists(path)) {
//	    // opcional: tentar deletar; se falhar, lidar com fallback
//	    file_delete(path);
//	}

//	var fw2 = file_text_open_write(path);
//	file_text_write_string(fw2, text);
//	file_text_close(fw2);

//	/// 3) remove tmp
//	if (file_exists(tmp)) file_delete(tmp);

//	return true;

//}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// @desc Lê e retorna o conteúdo de um arquivo de texto. 
/// @desc Retorna "" caso o arquivo não exista ou estiver vazio
/// @param {string} path - Caminho do arquivo a ser lido.
function read_text_file(path) {
	if (!file_exists(path)) return "";

	var fr = file_text_open_read(path);
	var content = "";
	var safety = 0;
	var SAFETY_LIMIT = 200000;

	while (!file_text_eof(fr) && safety < SAFETY_LIMIT) {
	    var line = file_text_readln(fr);
	    content += line;
	    if (!file_text_eof(fr)) content += "\n";
	    safety += 1;
	}
	file_text_close(fr);

	if (safety >= SAFETY_LIMIT) {
	    show_debug_message("scr_read_text_file: safety limit atingido ao ler " + path);
	    return "";
	}

	return content;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

//function read_text_file(path) {
//	if (!file_exists(path)) return "";

//	var fr = file_text_open_read(path);
//	var content = "";
//	while (!file_text_eof(fr)) {
//	    content += file_text_read_string(fr);
//	    if (!file_text_eof(fr)) content += "\n";
//	}
//	file_text_close(fr);
//	return content;
//}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

// Função chamada quando jogador escolhe "Sair para o Lobby"
function on_player_exit_room() {
    // 1) atualiza posição do player no save_state.player (opcional)
    if (instance_exists(obj_player)) {
        var px = obj_player.x;
        var py = obj_player.y;
        if (variable_global_exists("save_state")) {
            obj_save_manager.save_state.player.x = px;
            obj_save_manager.save_state.player.y = py;
            obj_save_manager.save_state.player.room_index = room;
            obj_save_manager.save_state.player.room_name = room_get_name(room);
        }
    }

    // 2) salva o estado da sala em memória
    with (obj_save_manager) {
        save_room_state(room_get_name(room)); // grava em save_state.rooms
    }

    // 3) opcional: gravar em disco no slot 1
    with (obj_save_manager) {
        save_slot(1); // escreve JSON (faz backup e atomic write)
    }

    // 4) ir para lobby
    room_goto(rm_lobby); // seu room index para o lobby
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function on_checkpoint_reached() {
    // atualiza player no save_state
    if (instance_exists(obj_player)) {
        obj_save_manager.save_state.player.x = obj_player.x;
        obj_save_manager.save_state.player.y = obj_player.y;
        obj_save_manager.save_state.player.room_index = room;
        obj_save_manager.save_state.player.room_name = room_get_name(room);
    }

    // salva room state e grava em disco (slot automático)
    with (obj_save_manager) {
        save_room_state(room_get_name(room));
        save_slot(1); // autosave no slot 1
    }

    // feedback
    show_message("Checkpoint salvo.");
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function ensure_player_not_carrying_for_save() {
    if (!instance_exists(obj_player)) return;
    with (obj_player) {
        if (variable_instance_exists(id, "carrying") && carrying != noone) {
            var carried = carrying;
            // se for datacore ou crystal, soltar no chão à frente do player
            if (instance_exists(carried) && (carried.object_index == obj_datacore || carried.object_index == obj_crystal)) {
                // posiciona no chão à frente conforme face
                var off = 16;
                var nx = x; var ny = y;
                switch (face) {
                    case RIGHT: nx += off; break;
                    case LEFT:  nx -= off; break;
                    case UP:    ny -= off; break;
                    case DOWN:  ny += off; break;
                }
                with (carried) {
                    carried_by = noone;
                    in_tower = noone;
                    x = other.nx;
                    y = other.ny;
                }
                carrying = noone;
            } else {
                // se for outro tipo, apenas drop normal
                _drop_box(); // seu método antigo
            }
        }
    }
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>


