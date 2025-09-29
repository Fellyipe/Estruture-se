// Expectativa: antes de criar esta instância, quem criar definirá:
//    o.target_id = <id_da_instancia_que_será_editada>
//    o.init_text = "<texto_inicial>"
// Se não foram definidos, inicializa defaults simples.

//if (!variable_instance_exists(self, "target_id")) target_id = noone;
//if (!variable_instance_exists(self, "init_text")) init_text = "";

max_length  = 128;
input_text  = string(init_text);
caret_timer  = 0;
caret_blink  = 30;
caret_on     = true;

box_w = 560;
box_h = 120;
//box_x = (display_get_gui_width() - box_w) / 2;
//box_y = display_get_gui_height() - box_h - 60;
box_x = (camera_get_view_width(view_camera[0]) - box_w) / 2;
box_y = camera_get_view_height(view_camera[0]) - box_h - 60;


// limpa buffer de teclado
//keyboard_clear();
keyboard_string = "";

// bloqueia input de jogo via flag simples
global.ui_blocked = true;
