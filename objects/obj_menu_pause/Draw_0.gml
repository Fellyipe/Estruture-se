// Desenha o snapshot congelado (se existir)
if (surface_exists(surf_pause)) {
    draw_surface(surf_pause, 0, 0);
} else {
    // fallback: desenha normalmente um fundo escuro
    draw_clear(c_black);
}

// Chama event_inhered
event_inherited();

