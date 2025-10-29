//draw_sprite(icon_sprite,0,x,y);

draw_self();


if (is_highlighted) {
        // draw com tint / glow simples
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(120,200,255), 1);
        // desenha normal por cima (toque final)
        //draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
}