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

if (value != "null" && energized) {
	draw_sprite_ext(spr_effect_energized, effect_image_index, x, y -24, 1, 1, 0, c_white, 0.6);
}


// overlay de flash (simples)
if (flash_timer > 0) {
    var a = clamp(flash_timer / max(1, flash_timer), 0.2, 1); // valor usado para alpha (simples)
    // desenha um retângulo sutil ao redor (ou troque por draw_sprite_ext)
    draw_set_alpha(0.55);
    draw_set_color(flash_color);
    //var bbox = sprite_get_bbox(sprite_index);
    // desenhar uma borda simples; ajustar tamanhos se quiser
    draw_rectangle(x - 18, y - 18, x + 18, y + 18, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}


if(value_locked) {
	draw_sprite(spr_terminal, 1, x, y + 12)
} else {
	draw_sprite(spr_terminal, 0, x, y + 12)
} 
if locked draw_sprite(spr_pointer_crystal_locked, 0, x, y - 12);
