//if (incoming_count > 0 && occupied) {
//    // pulso simples
//    var pulse = 0.08 * sin(current_time * 0.006); // current_time dá tempo em ms; ajuste velocidade
//    var alpha = 0.35 + 0.25 * (1 + sin(current_time * 0.006)); // 0.10..0.60

//    // tint do sprite (fallback simples)
//    draw_set_color(make_color_rgb(64,200,255)); // ciano elétrico
//    draw_set_alpha(alpha);
//    // redesenha o sprite por cima com blend aditivo para parecer glow
//    //draw_set_blend_mode(bm_add);
//    draw_sprite_ext(sprite_index, image_index, x, y, 1 + pulse, 1 + pulse, image_angle, c_white, 1);
//    //draw_set_blend_mode(bm_normal);
//    draw_set_alpha(1);
//} else {
//	draw_self();
//}

/// Draw - obj_crystal (exemplo)
if (is_highlighted) {
    // desenha primeiro uma versão tint levemente
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(120,200,255), 0.65);
}
// depois desenha o sprite normal
draw_sprite(actual_sprite, image_index, x, y);


if (value != "null" && energized) {
	draw_sprite_ext(spr_effect_energized, effect_image_index, x, y -24, 1, 1, 0, c_white, 0.6);
}




if(value_locked) {
	draw_sprite(spr_terminal, 1, x, y + 12)
} else {
	draw_sprite(spr_terminal, 0, x, y + 12)
} 
if locked draw_sprite(spr_pointer_crystal_locked, 0, x, y - 12);
