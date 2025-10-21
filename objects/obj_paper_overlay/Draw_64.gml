/// obj_paper_overlay - Draw GUI
if (!is_open) exit;

// dimensões GUI
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// dimmer
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, sw, sh, false);
draw_set_alpha(1);

// painel central (opcional — desenhe quad com borda por baixo da sprite)
var pw = sw * 0.78;
var ph = sh * 0.78;
var px = (sw - pw) / 2;
var py = (sh - ph) / 2;

draw_set_color(make_color_rgb(18,20,24));
draw_rectangle(px - 8, py - 8, px + pw + 8, py + ph + 8, false);

// desenhar sprite (mantendo aspecto)
if (gui_sprite != noone && sprite_exists(gui_sprite)) {
    var spr_w = sprite_get_width(gui_sprite);
    var spr_h = sprite_get_height(gui_sprite);

    // escala para caber no painel com margem (mantendo aspecto)
    var max_w = pw * 0.96;
    var max_h = ph * 0.90;
    var sx = max_w / spr_w;
    var sy = max_h / spr_h;
    var smin = min(sx, sy) * scale;

    var cx = px + pw / 2;
    var cy = py + ph / 2;
    draw_sprite_ext(gui_sprite, 0, cx, cy, smin, smin, 0, c_white, 1);
}

// se mode == "addresses", desenhar texto sobre o paper (com quebra de linha)
if (mode == "addresses" && string_length(addresses_text) > 0) {
    draw_set_font(fnt_menu);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    var text_x = px + 36;
    var text_y = py + 40;
    var text_w = pw - 72;
    // draw_text_ext para wrap
    draw_text_ext(text_x, text_y, addresses_text, text_w, 22);
}

// dica de fechamento (rodapé)
draw_set_font(fnt_menu);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(make_color_rgb(160,160,160));
draw_text(px + pw/2, py + ph - 12, "E / Esc — Fechar");

// restaurar estados de desenho
draw_set_alpha(1);
draw_set_color(c_white);
