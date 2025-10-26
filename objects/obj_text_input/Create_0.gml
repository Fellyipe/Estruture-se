//// Expectativa: antes de criar esta instância, quem criar definirá:
////    o.target_id = <id_da_instancia_que_será_editada>
////    o.init_text = "<texto_inicial>"
//// Se não foram definidos, inicializa defaults simples.

////if (!variable_instance_exists(self, "target_id")) target_id = noone;
////if (!variable_instance_exists(self, "init_text")) init_text = "";

//max_length  = 128;
//input_text  = string(init_text);
//caret_timer  = 0;
//caret_blink  = 30;
//caret_on     = true;

//box_w = 560;
//box_h = 120;
////box_x = (display_get_gui_width() - box_w) / 2;
////box_y = display_get_gui_height() - box_h - 60;
//box_x = (camera_get_view_width(view_camera[0]) - box_w) / 2;
//box_y = camera_get_view_height(view_camera[0]) - box_h - 60;


//// limpa buffer de teclado
////keyboard_clear();
//keyboard_string = "";

//// bloqueia input de jogo via flag simples
//global.ui_blocked = true;

// CONFIGURAÇÕES DA CAIXA DE TEXTO
max_length = 128;
input_text = string(init_text); // Texto inicial definido por quem criou o objeto

// APARÊNCIA (substitua pelos nomes dos seus assets)
//spr_panel = spr_panel_9slice; // Seu sprite 9-slice para o painel principal
//spr_input_box = spr_input_field_9slice; // Seu sprite 9-slice para o campo de texto
fnt_label = fnt_primary_36; // Fonte para o título/instrução
fnt_input = fnt_primary_24; // Fonte para o texto que o jogador digita

// DIMENSÕES E POSICIONAMENTO (serão calculadas no Draw GUI)
panel_w = 600; // Largura desejada do painel
panel_h = 176; // Altura desejada do painel
padding = 24; // Espaçamento interno para todos os elementos

// EFEITOS E ANIMAÇÃO
display_scale = 0; // Começa invisível para a animação de "pop-up"
caret_timer = 0;
caret_blink_speed = 0.05; // Velocidade do piscar do cursor

// ESTADO E CONTROLE
keyboard_string = ""; // Limpa o buffer do teclado ao abrir
global.ui_blocked = true; // Bloqueia outras UIs

caret_alpha = 0;
error_timer = 0;

