/// @desc Retorna o nome do arquivo de salvamento,
/// @desc formatado como "save_slotX.json", onde X é o número do slot.
/// @param {any*} slot  O número do slot de salvamento (ex: 1, 2, 3).=
function save_json_filename(slot) {
	return "save_slot" + string(slot) + ".json";
}

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