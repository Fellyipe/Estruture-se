 event_inherited();

var _id = id;

menu_label = "PAUSA";

menu_items = [
    { 
		text: "▶ Retomar",  
		name: "resume",
		use_id: true,
		action: function(_id) { instance_destroy(_id); } 
	},
    { 
		text: "Salvar",  
		name: "save",
		use_id: false,
		action: function() { obj_save_manager.save_slot(2);  } 
	},
    { 
		text: "Carregar",  
		name: "load",
		use_id: false,
		action: function() { show_message(obj_save_manager.save_state.meta.version); obj_save_manager.load_slot(2); show_message(obj_save_manager.save_state.meta.version) } 
	},
    { 
		text: "✖ Sair",  
		name: "back",
		use_id: true,
		action: function(_id) { 
			instance_destroy(_id); 
			with (obj_player) {
			    instance_destroy();
			}
			room_goto(rm_main_menu); 	
		} 
	},
];

// Contador de pausas (stack)
global.pause_count += 1;
global.is_paused = true;




surf_pause = -1;

if (surface_exists(application_surface)) {
    // libera qualquer surface antiga, só por segurança
    if (variable_instance_exists(self, "surf_pause") && surface_exists(surf_pause)) {
        surface_free(surf_pause);
    }
    // tenta criar a surface do tamanho da room
    surf_pause = surface_create(room_width, room_height);
    if (surface_exists(surf_pause)) {
        surface_set_target(surf_pause);
        draw_clear_alpha(c_black, 0);            // limpa a surface
        // copia o que está sendo mostrado na tela (application_surface)
        draw_surface(application_surface, 0, 0);
        surface_reset_target();
    }
}



// Lista de tipos a serem desativados (poderá ser passada ao criar a instância)
if (!variable_instance_exists(self, "pause_targets")) {
    pause_targets = [obj_enemy];
}

// Desativa tipos passados (não desativa o próprio overlay)
for (var i = 0; i < array_length(pause_targets); i++) {
    var t = pause_targets[i];
    if (t != object_index) instance_deactivate_object(t);
}

// Diminui a música
audio_group_set_gain(BGM, audio_group_get_gain(BGM) * 0.5, 1500);