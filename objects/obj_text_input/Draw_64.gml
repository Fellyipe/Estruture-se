//draw_set_font(font);

//// fundo geral semitransparente
////draw_set_color(c_black);
////draw_rectangle(0,0,display_get_gui_width(), display_get_gui_height(), false);

//// caixa central
//draw_set_color(c_gray);
//draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

//// label
//draw_set_color(c_white);
//draw_set_halign(fa_left);
//draw_set_valign(fa_top);
//draw_text(box_x + 16, box_y + 12, "Editar valor (Enter = salvar, Esc = cancelar):");

//// área de texto
//var tx = box_x + 16;
//var ty = box_y + 44;
//var tw = box_w - 32;

//draw_set_color(c_maroon);
//draw_rectangle(tx - 4, ty - 4, tx + tw + 4, ty + 28 + 4, false);

//draw_set_color(c_white);
//draw_text_ext(tx, ty, input_text, tw, 20);

//// caret
//if (caret_on) {
//    var caret_x = tx + string_width(input_text);
//    var caret_y1 = ty;
//    var caret_y2 = ty + 20;
//    draw_line(caret_x, caret_y1, caret_x, caret_y2);
//}

//// dica
//draw_set_halign(fa_right);
//draw_text(box_x + box_w - 14, box_y + box_h - 18, "Pressione Enter para salvar");




// =============================================================================
// EVENTO DRAW GUI PARA obj_text_input
// =============================================================================

// --- 1. CALCULAR POSIÇÕES E TAMANHOS ---
// Usamos as funções 'display_get_gui_*' para garantir que a UI
// fique perfeitamente centralizada, independente da câmera ou resolução.
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// O ponto central da tela será nossa âncora para a animação.
var center_x = gui_w / 2;
var center_y = gui_h / 2;

// --- 2. DESENHAR FUNDO E ANIMAÇÃO ---
// A variável 'display_scale' (que é atualizada no Evento Step)
// controla a animação de "pop-up" do painel.

// Fundo escurecido semitransparente para focar na UI.
draw_set_color(c_black);
draw_set_alpha(0.6 * display_scale); // O fundo aparece suavemente junto com o painel.
draw_rectangle(0, 0, gui_w, gui_h, false);

// --- 3. DESENHAR O PAINEL E SEU CONTEÚDO ---
// Só continuamos se o painel estiver minimamente visível.
if (display_scale < 0.1) {
    draw_set_alpha(1.0); // Reseta o alpha antes de sair.
    exit;
}

// Painel principal: Usamos draw_sprite_ext para controlar a escala.
// O ideal é que 'spr_panel' seja um sprite 9-slice para esticar sem distorcer as bordas.
//draw_sprite_ext(
//    spr_panel,      // Seu sprite para o painel de fundo.
//    0,              // Sub-imagem (frame).
//    center_x,       // Posição X central.
//    center_y,       // Posição Y central.
//    display_scale,  // Escala X (controlada pela animação).
//    display_scale,  // Escala Y (controlada pela animação).
//    0,              // Rotação.
//    c_white,        // Cor.
//    1               // Alpha (opacidade).
//);

// A partir daqui, só desenhamos o conteúdo se o painel estiver quase todo aberto.
if (display_scale < 0.95) {
    draw_set_alpha(1.0);
    exit;
}

// Calcula as bordas do painel para alinhar o conteúdo dentro dele.
var panel_x1 = center_x - (panel_w / 2);
var panel_y1 = center_y - (panel_h / 2);
draw_set_alpha(1.0);
draw_sprite_stretched(spr_panel, 0, panel_x1, panel_y1, panel_w, panel_h);


// Título / Instrução
draw_set_font(fnt_label);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(panel_x1 + padding, panel_y1 + padding - 12, "Editar Valor do Ponteiro");

// Caixa de Input (usando um sprite 9-slice para a caixa).
var input_field_x = panel_x1 + padding;
var input_field_y = panel_y1 + padding + 40; // Deslocamento abaixo do título.
var input_field_w = panel_w - (padding * 2);
var input_field_h = 48;
draw_sprite_stretched(spr_tab, 0, input_field_x, input_field_y, input_field_w, input_field_h);

// Texto que o usuário está digitando.
draw_set_font(fnt_input);
draw_set_valign(fa_middle); // Alinha o texto verticalmente no meio da caixa.
draw_text(input_field_x + 10, input_field_y + input_field_h / 2, input_text);

// Cursor (Caret) com piscar suave.
// A variável 'caret_alpha' é calculada no Evento Step com sin() para o efeito.
var caret_x = input_field_x + 10 + string_width(input_text);
var caret_y = input_field_y + (input_field_h / 2);
draw_set_alpha(caret_alpha); // Aplica o alfa do piscar.
draw_line_width_color(caret_x, caret_y - 12, caret_x, caret_y + 12, 2, c_white, c_white);

if (error_timer > 0) {
    draw_set_font(fnt_input);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_red); // Cor vermelha para o erro
    
    // Posição do texto de erro, logo abaixo da caixa de input.
    var error_x = input_field_x;
    var error_y = input_field_y + input_field_h + 28; // 8 pixels de espaçamento.
    
    // Texto de erro mais informativo.
    var error_text = "Formato inválido. Use 'null' ou '0xXXXX'.";
    
	draw_set_alpha(error_timer > 180 ? 1 : error_timer / 180);
    draw_text(error_x, error_y, error_text);
}

// Dica de comandos no rodapé do painel.
draw_set_font(fnt_input);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(c_silver); // Uma cor mais sutil para a dica.
draw_set_alpha(1.0);
draw_text(center_x, panel_y1 + panel_h - padding - 12, "Pressione [Enter] para Salvar ou [Esc] para Cancelar");

// --- 4. RESETAR ESTADOS DE DESENHO ---
// Essencial para não afetar outros elementos da sua GUI.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1.0);