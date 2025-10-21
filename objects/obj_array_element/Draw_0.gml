draw_self();


// desenha value e dicas
draw_set_font(label_font);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(label_color);
//draw_text(x, y - sprite_bottom_offset - 8, payload);


// dica de interação
// var p2 = instance_nearest(x, y, obj_player);

// desenha var_name
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
if(occupied) draw_set_color(c_gray);
draw_text_transformed(x, y, var_name, 0.5, 0.5, 0);