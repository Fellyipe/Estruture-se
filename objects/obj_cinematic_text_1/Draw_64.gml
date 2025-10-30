/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
/// Draw - obj_cinematic_text
var sw = display_get_width();
var sh = display_get_height();

draw_set_alpha(overlay_alpha);
draw_set_color(c_black);
draw_rectangle(0,0,sw,sh,false);
draw_set_alpha(1);

// Painel central
var panel_w = min(panel_max_w, sw * 0.9);
var panel_h_max = sh * 0.6;
var px = sw * 0.5;
var py = sh * 0.5;

if (panel_sprite != noone && sprite_exists(panel_sprite)) {
    var spr_w = sprite_get_width(panel_sprite);
    var spr_h = sprite_get_height(panel_sprite);
    var scale = min(panel_w / spr_w, panel_h_max / spr_h, 1.0);
    var draw_w = spr_w * scale;
    var draw_h = spr_h * scale;

    draw_set_alpha(panel_alpha);
    draw_sprite_ext(panel_sprite, 0, px, py, scale, scale, 0, c_white, 1);
    draw_set_alpha(1);

    var text_box_w = draw_w - panel_pad*2;
    var text_box_h = draw_h - panel_pad*2;
    var text_x = px;
    var text_y = py - text_box_h*0.5 + panel_pad*0.5;
    var draw_h = draw_h;
} else {
    var draw_w = panel_w;
    var draw_h = min(panel_h_max, sh * 0.45);

    draw_set_alpha(panel_alpha);
    draw_set_color(panel_color);
    draw_rectangle(px - draw_w/2, py - draw_h/2, px + draw_w/2, py + draw_h/2, false);
    draw_set_alpha(1);

    var text_box_w = draw_w - panel_pad*2;
    var text_box_h = draw_h - panel_pad*2;
    var text_x = px;
    var text_y = py - text_box_h*0.5 + panel_pad*0.5;
}

// Texto: wrap simples por palavras
draw_set_font(font);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(text_color);

// split por palavras (usa string_split — se sua versão não tiver, me avisa que troco)
var words = string_split(text, " ");
var lines = [];
var current = "";
for (var i = 0; i < array_length(words); i++) {
    var w = words[i];
    var tryLine = (current == "" ? w : current + " " + w);
    if (string_width(tryLine) <= text_box_w) {
        current = tryLine;
    } else {
        if (current != "") array_push(lines, current);
        current = w;
        // quebra forçada de palavra longa
        if (string_width(w) > text_box_w) {
            var maxChars = max(1, floor(text_box_w / string_width("W")));
            var j = 0;
            while (j < string_length(w)) {
                var piece = string_copy(w, j+1, maxChars);
                array_push(lines, piece);
                j += maxChars;
            }
            current = "";
        }
    }
}
if (current != "") array_push(lines, current);

// desenha linhas centralizadas verticalmente
var line_h = string_height("A");
if (line_h <= 0) line_h = 18;
var total_h = array_length(lines) * line_h;
var start_y = py - (total_h / 2);

for (var k = 0; k < array_length(lines); k++) {
    var line_to_draw = lines[k];
    var yy = start_y + k * line_h;
    draw_text(px, yy, line_to_draw);
}

// hint no rodapé do painel
draw_set_font(font);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(make_color_rgb(180,180,180));
draw_text(px, py + draw_h/2 - 12, "Pressione Enter para continuar");
draw_set_color(c_white);
