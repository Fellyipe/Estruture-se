// Evento Step de obj_fade_teleport

if (fade_state == "out") {
    // Escurecendo a tela
    fade_alpha += fade_speed;
    if (fade_alpha >= 1) {
        fade_alpha = 1;

        // --- Momento do Teletransporte ---
        // A tela está totalmente preta, então movemos o jogador
        with (obj_player) {
            x = other.target_x;
            y = other.target_y;
            face = other.target_face;
        }

        // Mudamos para o estado de "clarear"
        fade_state = "in";
    }
}
else if (fade_state == "in") {
    // Clareando a tela
    fade_alpha -= fade_speed;
	
	if (!popup_called) {
		if (global.cur_day == "day_02") {
			show_popup_new_day("DIA 2")
		} else if(global.cur_day == "day_03") {
			show_popup_new_day("DIA 3")
		} else if(global.cur_day == "day_end") {
			show_popup_new_day("MENSAGEM FINAL")
		}
		popup_called = true;
	}
	if (fade_alpha <= 0) {
        fade_alpha = 0;
        fade_state = "done";
		
		//CREATE POPUP

        // O processo terminou, podemos destruir o objeto de fade
		global.ui_blocked = false;
        instance_destroy();
    }
}