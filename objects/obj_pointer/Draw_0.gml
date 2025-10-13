if (incoming_count > 0 && occupied) {
    // pulso simples
    var pulse = 0.08 * sin(current_time * 0.006); // current_time dá tempo em ms; ajuste velocidade
    var alpha = 0.35 + 0.25 * (1 + sin(current_time * 0.006)); // 0.10..0.60

    // tint do sprite (fallback simples)
    draw_set_color(make_color_rgb(64,200,255)); // ciano elétrico
    draw_set_alpha(alpha);
    // redesenha o sprite por cima com blend aditivo para parecer glow
    //draw_set_blend_mode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, 1 + pulse, 1 + pulse, image_angle, c_white, 1);
    //draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
} else {
	draw_self();
}

// desenha value e dicas
draw_set_font(label_font);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(label_color);
//draw_text(x, y - sprite_bottom_offset - 8, value);

// desenha var_name
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
if(energized) draw_set_color(c_gray);
draw_text_transformed(x, y, var_name, 0.5, 0.5, 0);


// dica de interação
// var p2 = instance_nearest(x, y, obj_player);
if (player_ref != noone && point_distance(x, y, player_ref.x, player_ref.y) <= prompt_distance) {
    draw_set_valign(fa_top);
    // mostra E para pegar/colocar e R para editar
	
	//if incoming_count == 1 draw_set_color(c_teal);
    //draw_text(x, y - sprite_get_bbox_bottom(sprite_index) - 48,
    //    "E: Pegar/Colocar     R: Editar valor");
	//draw_set_color(label_color);
}
