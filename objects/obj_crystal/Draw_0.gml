//draw_sprite(icon_sprite,0,x,y);

//if (is_targeted) {
//    // >> Opcional: mude a cor ou alfa para um efeito de pulso
//     var alpha = 0.7 + 0.3 * sin(get_timer() / 100000);
//     draw_sprite_ext(spr_highlight_outline, 0, x, y, image_xscale, image_yscale, image_angle, c_white, alpha);
    
//    // Versão simples:
//    //draw_sprite(spr_highlight_outline, 0, x, y);
//}					

if (is_highlighted) {
    // desenha primeiro uma versão tint levemente
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(120,200,255), 0.65);
}

draw_self();