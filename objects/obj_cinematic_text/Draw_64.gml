/// Draw GUI - obj_cinematic_text

// Calcula o alfa atual (código inalterado)
var current_alpha = 0;
switch(_state) {
    case "fading_in": current_alpha = (timer / fade_duration_seconds) * overlay_target_alpha; break;
    case "visible": current_alpha = overlay_target_alpha; break;
    case "fading_out": current_alpha = (timer / fade_duration_seconds) * overlay_target_alpha; break;
}

// Desenha o fundo preto (código inalterado)
if (current_alpha > 0) {
    draw_set_alpha(current_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
}
if (current_alpha < 0.1) exit;

// Coordenadas e Painel (código inalterado)
var sw = display_get_gui_width();
var sh = display_get_gui_height();
var panel_w = sw * panel_w_scale;  
var panel_h = sh * panel_h_scale;
var panel_x = (sw - panel_w) / 2;
var panel_y = (sh - panel_h) / 2;
var panel_pad = 32;
draw_sprite_stretched(panel_sprite, 0, panel_x, panel_y, panel_w, panel_h);

// >> NOVO: Lógica para construir o texto a ser desenhado
var text_to_draw = "";
// 1. Adiciona todos os parágrafos já concluídos
for (var i = 0; i < current_paragraph_index; i++) {
    text_to_draw += paragraphs[i] + "\n\n";
}
// 2. Adiciona a parte visível do parágrafo atual
text_to_draw += string_copy(paragraphs[current_paragraph_index], 1, floor(text_current_length));

// Desenha o Texto com quebra de linha automática (código inalterado)
draw_set_font(font);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var text_x = panel_x + panel_pad;
var text_y = panel_y + panel_pad;
var line_separation = string_height("A");
var wrap_width = panel_w - (panel_pad * 2);
draw_text_ext(text_x, text_y, text_to_draw, line_separation, wrap_width);

// >> MUDANÇA: Desenha a dica "Pressione Enter" se o PARÁGRAFO ATUAL terminou
var is_paragraph_finished = (text_current_length >= string_length(paragraphs[current_paragraph_index]));
if (_state == "visible" && is_paragraph_finished) {
    var blink_alpha = 0.6 + 0.4 * sin(get_timer() / 200000);
    draw_set_alpha(blink_alpha);
    draw_set_font(font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(180, 180, 180));
    draw_text(sw / 2, panel_y + panel_h - panel_pad, "Pressione Enter para continuar");
    draw_set_alpha(1);
}