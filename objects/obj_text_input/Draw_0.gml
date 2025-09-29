draw_set_font(font);

// fundo geral semitransparente
//draw_set_color(c_black);
//draw_rectangle(0,0,display_get_gui_width(), display_get_gui_height(), false);

// caixa central
draw_set_color(c_gray);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

// label
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(box_x + 16, box_y + 12, "Editar valor (Enter = salvar, Esc = cancelar):");

// área de texto
var tx = box_x + 16;
var ty = box_y + 44;
var tw = box_w - 32;

draw_set_color(c_maroon);
draw_rectangle(tx - 4, ty - 4, tx + tw + 4, ty + 28 + 4, false);

draw_set_color(c_white);
draw_text_ext(tx, ty, input_text, tw, 20);

// caret
if (caret_on) {
    var caret_x = tx + string_width(input_text);
    var caret_y1 = ty;
    var caret_y2 = ty + 20;
    draw_line(caret_x, caret_y1, caret_x, caret_y2);
}

// dica
draw_set_halign(fa_right);
draw_text(box_x + box_w - 14, box_y + box_h - 18, "Pressione Enter para salvar");
