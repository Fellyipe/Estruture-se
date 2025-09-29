/// obj_dialogue - DRAW
// desenha o conteúdo da room "por baixo" normalmente (não altere: este Draw roda sobre o que já foi desenhado)

var bx1 = box_margin;
var bx2 = room_width - box_margin;
var by2 = room_height - box_margin;
var by1 = by2 - box_height;

// fundo semitransparente
draw_set_color(make_color_rgba(0,0,0, box_color_alpha));
draw_rectangle(bx1, by1, bx2, by2, false);

// área do texto
var text_x = bx1 + 16;
var text_y = by1 + 20;
var text_width = (bx2 - bx1) - 32;

// se há portrait, reserva espaço
if (portrait_sprite != noone) {
    var p_x = bx1 + 16;
    var p_y = by1 + (box_height - portrait_size) / 2;
    // desenha portrait (centralizado verticalmente)
    draw_sprite_ext(portrait_sprite, portrait_subimg, p_x + portrait_size/2, p_y + portrait_size/2, portrait_size / sprite_get_width(portrait_sprite), portrait_size / sprite_get_height(portrait_sprite), 0, c_white, 1);
    // ajusta área de texto (afasta para a direita)
    text_x = p_x + portrait_size + portrait_padding;
    text_width = bx2 - text_x - 16;
}


// desenha namn do speaker (opcional)
draw_set_font(font_name);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
if (string_length(speaker_name) > 0) {
    draw_text(text_x, text_y - 22, speaker_name);
}

// desenha o texto parcial (usa draw_text_ext para wrap automático)
var text_to_draw = string_copy(text, 1, typed_chars);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext(text_x, text_y, text_to_draw, text_width, font_size_line);

// indicador "pressione para continuar" quando texto completo
if (!typing) {
    // desenha um pequeno triângulo piscante no canto direito baixo da caixa
    var indic_x = bx2 - 28;
    var indic_y = by2 - 24;
    // blink: só desenha parte do tempo
    if (blink_timer < blink_rate) {
        draw_triangle_color(indic_x, indic_y-8, indic_x+12, indic_y-4, indic_x, indic_y, c_white, c_white, c_white, false);
    }
}
