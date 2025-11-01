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
		//text: "✖ Sair",          
		text: "Sair",          
		action: function() { game_end(); } 
	}
];