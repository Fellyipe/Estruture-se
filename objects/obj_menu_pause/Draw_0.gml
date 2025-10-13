/// Draw - obj_menu_pause (corrigido)
var dm = noone;
if (instance_number(obj_display_manager) > 0) dm = instance_find(obj_display_manager, 0);

// desenha snapshot ajustado à janela atual (corrige zoom) — se possível usa offsets/zoom do dm
if (surface_exists(surf_pause)) {
    if (dm != noone && variable_instance_exists(dm, "offset_x") && variable_instance_exists(dm, "zoom")) {
        draw_surface_ext(surf_pause, dm.offset_x, dm.offset_y, dm.zoom, dm.zoom, 0, c_white, 1);
    } else {
        // fallback: desenha no canto superior esquerdo cobrindo a tela
        draw_surface(surf_pause, 0, 0);
    }
} else {
    // fallback: desenha fundo escuro
    draw_clear(c_black);
}

// chamamos o draw do parent (obj_menu_base) — isso desenha o painel/menu usando room_width/room_height
event_inherited();
