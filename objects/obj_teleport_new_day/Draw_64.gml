// Evento Draw GUI de obj_fade_teleport
draw_set_color(c_white); // Resetar a cor para branco (ou qualquer cor base)
draw_set_alpha(1);
// Se o alfa for maior que 0, desenha o retângulo preto
if (fade_alpha > 0) {
    // Define a cor e o alfa para o desenho
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);

    // Desenha um retângulo que cobre toda a tela
    var _gui_width = display_get_gui_width();
    var _gui_height = display_get_gui_height();
    draw_rectangle(0, 0, _gui_width, _gui_height, false);

    // Reseta o alfa para não afetar outros elementos desenhados
    draw_set_alpha(1);
}

draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(50, 50, 500, 500, false);
draw_sprite(spr_ts_stuff, 0, 0, 0);
show_debug_message("Draw GUI está rodando! Alpha: " + string(fade_alpha));