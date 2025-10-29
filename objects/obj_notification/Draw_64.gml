// obj_concept_notify - Draw GUI
// desenha sprite no centro-baixo (GUI coords)

var sw = display_get_gui_width();
var sh = display_get_gui_height();

// >> MUDANÇA: Adiciona um padding para o espaçamento das bordas
var padding = 24; // Ajuste este valor para mais ou menos espaço da borda

// >> MUDANÇA: Calcula as dimensões do sprite com a escala aplicada
// Isso é importante para posicionar corretamente, não importa o tamanho ou escala
var spr_w = sprite_get_width(sprite_to_draw) * image_xscale;
var spr_h = sprite_get_height(sprite_to_draw) * image_yscale;

// >> MUDANÇA: Calcula a posição X e Y para o canto inferior esquerdo
// A lógica assume que a origem do seu sprite está no CENTRO
var _x = sw - 2 * (padding + (spr_w / 2));
var _y = 2 * padding;

// desenho do sprite (se sprite definido)
if (sprite_to_draw != noone) {
    draw_set_alpha(image_alpha);
    // desenha centralizado
    var spr = sprite_to_draw;
    // se sprite_to_draw foi passado como string, tente converter - comum usar index though
    if (is_string(spr)) {
        // se você passar nomes, tente sprite_get_index (pode falhar em runtime)
        if (sprite_exists(asset_get_index(spr))) spr = asset_get_index(spr);
    }
    if (sprite_exists(spr)) {
        var swspr = sprite_get_width(spr);
        var shspr = sprite_get_height(spr);
        // escala base (opcional) - muda a gosto
        var scale = image_xscale;
        draw_sprite_ext(spr, 0, _x, _y, scale, scale, 0, c_white, image_alpha);
    } else {
        // fallback: desenha um círculo simples
        draw_set_alpha(image_alpha);
        draw_set_color(make_color_rgb(64,200,255));
        draw_circle(_x, _y, 18 * image_xscale, false);
    }
    draw_set_alpha(1);
}
