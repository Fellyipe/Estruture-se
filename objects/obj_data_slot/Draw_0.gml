//draw_self();

/// Draw - obj_crystal (exemplo)
if (is_highlighted) {
    // desenha primeiro uma versão tint levemente
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(120,200,255), 0.65);
}
// depois desenha o sprite normal
draw_sprite(actual_sprite, image_index, x, y);


if(locked) {
	draw_sprite(spr_blocked, 0, x, y + 12)
} 