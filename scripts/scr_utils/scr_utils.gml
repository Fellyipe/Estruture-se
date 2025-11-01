function get_pointer_by_address(address) {
	var _n = instance_number(obj_pointer);
	for (var i = 0; i < _n; ++i) {
	    var inst = instance_find(obj_pointer, i);
	    if (variable_instance_exists(inst, "address")) {
	        if (inst.address == address) return inst;
	    }
	}
	return noone;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function screen_to_virtual(mx, my) {
	var vx = (mx - obj_display_manager.offset_x) / obj_display_manager.zoom;
	var vy = (my - obj_display_manager.offset_y) / obj_display_manager.zoom;
	return { x: vx, y: vy };
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function virtual_to_screen(vx, vy) {
	var sx = vx * obj_display_manager.zoom + obj_display_manager.offset_x;
	var sy = vy * obj_display_manager.zoom + obj_display_manager.offset_y;
	return { x: sx, y: sy };
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// Creates a popup message in GUI. Use: scr_show_popup("Jogo salvo!", 3);
/// @param {string} msg                A mensagem a ser exibida.
/// @param {real}   [seconds=3]        Por quantos segundos a mensagem ficará visível.
/// @param {real}   [fade_seconds=0.4] Por quantos segundos o fade de entrada/saída durará.
function show_popup(msg, seconds = 3, fade_seconds = 0.4) {
    
    // Cria a instância na camada GUI (ou uma camada padrão)
    var lay_name = "GUI";
    if (!layer_exists(lay_name)) {
        lay_name = "Instances"; // Camada de fallback
    }
    
    var inst = instance_create_layer(0, 0, lay_name, obj_popup_message);

    // Configura as variáveis de tempo diretamente na instância
    inst.text = string(msg);
    inst.visible_duration_seconds = seconds;
    inst.fade_duration_seconds = fade_seconds;
    
    return inst;
}

function show_popup_new_day(msg, seconds = 3, fade_seconds = 0.4) {
    
    // Cria a instância na camada GUI (ou uma camada padrão)
    var lay_name = "GUI";
    if (!layer_exists(lay_name)) {
        lay_name = "Instances"; // Camada de fallback
    }
    
    var inst = instance_create_layer(0, 0, lay_name, obj_popup_new_day);

    // Configura as variáveis de tempo diretamente na instância
    inst.text = string(msg);
    inst.visible_duration_seconds = seconds;
    inst.fade_duration_seconds = fade_seconds;
    
    return inst;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// id   -> string id do conceito (ex: "concept.pointers")
/// spr  -> (opcional) sprite index ou sprite name; se não passado, usa global.spr_notify se existir.
function show_concept_notify() {	
	// limpa notificações antigas (apenas 1 de cada vez)
	//with (obj_notification) {
	//    instance_destroy();
	//}

	//// criar na layer GUI (ou nome da sua layer)
	//var lay = "GUI";
	//if (!layer_exists(lay)) lay = layer_get_id("Instances"); // fallback
	//var inst = instance_create_layer(0, 0, lay, obj_notification);
	////inst.spawn_room = room_get_name(room);
	//return inst;
	return noone;
}