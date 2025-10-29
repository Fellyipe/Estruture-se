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