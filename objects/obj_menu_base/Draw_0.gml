draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_menu);

var start_y = room_height * 2/7;
var spacing = 50;
var cx = room_width / 2;

// Desenha o painel de fundo
draw_set_color(c_black);
var panelx1 = 1/7 * room_width;
var panelx2 = room_width - panelx1;
var panely1 = 1/7 * room_height;
var panely2 = room_height - panely1;

draw_rectangle(panelx1, panely1, panelx2, panely2, false);

// Título
draw_set_color(c_white);
draw_text(room_width/2, 2/11 * room_height, menu_label);

for (var i = 0; i < array_length(menu_items); i++) {
    var text = menu_items[i].text;
    var y_text = start_y + i * spacing;
    
    if (i == selected_index) {
        draw_set_color(c_yellow);
        draw_text(cx, y_text, "> " + text);
    } else {
        draw_set_color(c_white);
        draw_text(cx, y_text, text);
    }
}