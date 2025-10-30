event_inherited(); // Chama o evento Criar do pai

menu_label = "Menu Principal";
global.ui_blocked = true;

menu_items = [
    { 
		///text: "▶ Iniciar Jogo",  
		text: "Iniciar Jogo",  
		action: function() { 
			global.ui_blocked = false;
			room_goto(rm_intro_scene);
	} 
	},
    { 
		//text: "⚙ Opções",        
		text: "Opções",        
		action: function() { 
				if (instance_exists(obj_menu_options)) {
				    // se já existir, só reativa
				    instance_activate_object(obj_menu_options);
					instance_deactivate_object(obj_menu_main);
				} else {
				    // senão, cria e já garante que o menu base fique dormindo
				    instance_deactivate_object(obj_menu_main);
				    var o = instance_create_layer(0, 0, "GUI", obj_menu_options);
				}
			} 
	},
    //{ 
	//	text: "? Tutorial",      
	//	action: function() { 
	//			if (instance_exists(obj_menu_tutorial)) {
	//			    // se já existir, só reativa
	//			    instance_activate_object(obj_menu_tutorial);
	//				instance_deactivate_object(obj_menu_main);
	//			} else {
	//			    // senão, cria e já garante que o menu base fique dormindo
	//			    instance_deactivate_object(obj_menu_main);
	//			    var o = instance_create_layer(0, 0, "GUI", obj_menu_tutorial);
	//			}
	//		} 
	//},
    { 
		//text: "⋯ créditos",      
		text: "Créditos",      
		action: function() { 
				if (instance_exists(obj_menu_credits)) {
				    // se já existir, só reativa
				    instance_activate_object(obj_menu_credits);
					instance_deactivate_object(obj_menu_main);
				} else {
				    // senão, cria e já garante que o menu base fique dormindo
				    instance_deactivate_object(obj_menu_main);
				    var o = instance_create_layer(0, 0, "GUI", obj_menu_credits);
				}
			} 
	},
    { 
		//text: "✖ Sair",          
		text: "Sair",          
		action: function() { game_end(); } 
	}
];