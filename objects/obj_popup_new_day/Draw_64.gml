// desenha a faixa no centro-baixo da GUI

// coordenadas GUI
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// painel dimensões (ajustáveis)
var max_w = sw * 0.7;
var padding_x = 18;
var padding_y = 12;
var tw = string_width(text);

var panel_w = min(max_w, tw + padding_x * 2);
var panel_h = 28 + padding_y;
var px = (sw - panel_w) / 2;
var py_base = sh - 90 + y_offset; // posição base (ajuste -90 conforme layout)
var py = py_base;
var py = (sh - panel_h) / 2;

if (alpha > 0) {
    draw_set_alpha(alpha * 0.6);
	if(state == "fading_in") draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
}

// texto
draw_set_alpha(alpha);
draw_set_font(font_to_use);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);

draw_sprite(spr_day_x, index_to_use, px + panel_w / 2, py + panel_h / 2);

// restore
draw_set_alpha(1);
draw_set_color(c_white);
