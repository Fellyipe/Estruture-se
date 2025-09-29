// Fundo escuro
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

// Texto de créditos centralizado
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(fnt_menu); // ou qualquer fonte que esteja usando

var cx = room_width / 2;
var cy = 80;
var spacing = 32;

for (var i = 0; i < array_length(credit_lines); i++) {
    draw_text(cx, cy + i * spacing, credit_lines[i]);
}

// Desenhar o botão "Voltar"
var btn_y = room_height - 80;
draw_set_color(selected_index == 0 ? c_yellow : c_white);
draw_text(cx, btn_y, "Voltar");
