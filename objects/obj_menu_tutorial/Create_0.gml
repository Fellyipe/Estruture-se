event_inherited();

menu_label   = "TUTORIAL";

menu_items = [
    { 
		text: "Se vire",	
		action: function() { /*volume_music = clamp(volume_music + 0.1,0,1);*/ } 
	},
    { 
		text: "Irmão",		
		action: function() { /*volume_sfx   = clamp(volume_sfx   + 0.1,0,1);*/ } 
	},
    { 
		text: "Voltar",			
		action: function() {  
				if (instance_exists(obj_menu_main)) {
				    // se já existir, só reativa
				    instance_activate_object(obj_menu_main);
					instance_deactivate_object(obj_menu_tutorial);
				} else {
				    // senão, cria e já garante que o menu base fique dormindo
				    var o = instance_create_layer(0, 0, "GUI", obj_menu_main);
					instance_deactivate_object(obj_menu_tutorial);
				}
			} 
	},
];
