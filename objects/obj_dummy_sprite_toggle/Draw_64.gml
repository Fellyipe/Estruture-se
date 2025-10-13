if (visible) {
    // Centraliza o sprite na GUI
    var x_center = (display_get_width() - sprite_width) / 2;
    var y_center = (display_get_height() - sprite_height) / 2;
    
    // Desenha o sprite
    draw_sprite(sprite_index, 0, x_center, y_center);
}
