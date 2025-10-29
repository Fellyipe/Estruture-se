//draw_self();


//if (is_highlighted) {
//        // draw com tint / glow simples
//        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(120,200,255), 1);
//        // desenha normal por cima (toque final)
//        //draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
//}

/// Draw - obj_crystal (exemplo)
if (is_highlighted) {
    // desenha primeiro uma versão tint levemente
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(120,200,255), 0.65);
}
// depois desenha o sprite normal
draw_self();
