// Desenha o logo centralizado
var cx = room_width / 2;
var cy = room_height / 3; // Para que fique um pouco elevada
draw_sprite_ext(
    splash_sprite,      // sprite do logo
    0,                // subimagem
    cx, cy,           // posição
    sprite_scale, sprite_scale,             // escala X e Y
    0,                // rotação
    c_white,          // cor de tinta
    alpha             // alpha (já aplicado acima)
);

// Restaura alpha padrão para outros draws
//draw_set_alpha(1);
