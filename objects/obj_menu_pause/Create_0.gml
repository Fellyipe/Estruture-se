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
		action: function() { 
				var rn = room_get_name(room);
				with (obj_save_manager) {
					var room_rec = save_room_state_simple(rn); // retorna struct
					if (!variable_struct_exists(save_state,"rooms")) save_state.rooms = {};
					save_state.rooms[$ rn] = room_rec;
					save_state.player = { x: obj_player.x, y: obj_player.y, room_index: room, room_name: room_get_name(room) };
					save_slot(1);
				}
			} 
	},
    { 
		text: "Carregar",  
		name: "load",
		use_id: false,
		action: function() { 
				with (global.save_manager) load_slot(1);

			} 
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



// Lista de tipos a serem desativados (poderá ser passada ao criar a instância)
if (!variable_instance_exists(self, "pause_targets")) {
    pause_targets = [obj_enemy];
}


// Desativa tipos passados (não desativa o próprio overlay)
for (var i = 0; i < array_length(pause_targets); i++) {
    var t = pause_targets[i];
    if (t != object_index) instance_deactivate_object(t);
}


// Snapshot surface (prefer display_manager.render_surface instance)
surf_pause = -1;
var dm = noone;
// get an actual instance of obj_display_manager if it exists
if (object_exists(obj_display_manager)) {
    if (instance_number(obj_display_manager) > 0) {
        dm = instance_find(obj_display_manager, 0);
    }
}
if (dm != noone && variable_instance_exists(dm, "render_surface") && surface_exists(dm.render_surface)) {
    // create snapshot with same size as render_surface
    var aw = surface_get_width(dm.render_surface);
    var ah = surface_get_height(dm.render_surface);
    if (surface_exists(surf_pause)) surface_free(surf_pause);
    surf_pause = surface_create(aw, ah);
    if (surface_exists(surf_pause)) {
        surface_set_target(surf_pause);
        draw_clear_alpha(c_black, 0);
        draw_surface(dm.render_surface, 0, 0);
        surface_reset_target();
    } else {
        surf_pause = -1;
    }
} else if (surface_exists(application_surface)) {
    // fallback: copy application_surface (may scale differently)
    var aw = surface_get_width(application_surface);
    var ah = surface_get_height(application_surface);
    if (surface_exists(surf_pause)) surface_free(surf_pause);
    surf_pause = surface_create(aw, ah);
    if (surface_exists(surf_pause)) {
        surface_set_target(surf_pause);
        draw_clear_alpha(c_black, 0);
        draw_surface(application_surface, 0, 0);
        surface_reset_target();
    } else {
        surf_pause = -1;
    }
} else {
    surf_pause = -1;
}

// audio: store original BGM gain and reduce safely
if (!is_undefined(BGM)) {
    if (!variable_instance_exists(self, "saved_bgm_gain")) saved_bgm_gain = audio_group_get_gain(BGM);
    audio_group_set_gain(BGM, saved_bgm_gain * 0.5, 1500);
}





pauser_object = instance_create_layer(-50, -50, "Instances", obj_pauser);