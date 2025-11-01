/// @description Gerencia os estados de fade e a animação usando delta_time.

// Converte delta_time de microssegundos para segundos
var _dt_sec = delta_time / 1000000.0;

// Incrementa o timer com o tempo real que passou
timer += _dt_sec;
var progress = 0;

switch (state) {
    case "fading_in":
        // Calcula o progresso do fade-in (0 a 1) com base no tempo
        progress = clamp(timer / fade_duration_seconds, 0, 1);
        alpha = progress; // Alpha vai de 0 a 1
        y_offset = (1 - progress) * slide_distance; // Desliza de baixo para cima

        // Transição para o próximo estado
        if (timer >= fade_duration_seconds) {
            state = "visible";
            timer = 0; // Reinicia o timer para o próximo estado
            alpha = 1;
            y_offset = 0;
        }
        break;

    case "visible":
        // Fica parado e totalmente visível
        // Transição para o próximo estado
        if (timer >= visible_duration_seconds) {
            state = "fading_out";
            timer = 0; // Reinicia o timer para o próximo estado
			if(!global.tab_tutorial_opened) {
				global.tab_tutorial_opened = true;
				instance_create_layer(0, 0, "GUI", obj_popup_close_tab);
			}
        }
        break;

    case "fading_out":
        // Calcula o progresso do fade-out (0 a 1) com base no tempo
        progress = clamp(timer / fade_duration_seconds, 0, 1);
        alpha = 1 - progress; // Alpha vai de 1 a 0
        y_offset = -progress * slide_distance; // Desliza para cima ao sair

        // Destrói a instância ao final
        if (timer >= fade_duration_seconds) {
			global.ui_blocked = false;
            instance_destroy();
        }
        break;
}

