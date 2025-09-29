portrait_sprite = spr_portrait_default;
char_speed       = 45;            // caracteres por segundo (padrão)
on_close         = undefined;     // função callback (opcional)

/// Layout / estilo (ajuste a gosto)
box_margin       = 24;            // margem da caixa nas bordas da room
box_height       = 160;           // altura da caixa
box_color_alpha  = 200;           // 0-255 alpha do fundo
box_color        = c_black;

font_size_line   = 22;            // espaçamento entre linhas (usado por draw_text_ext)

// portrait
portrait_size    = 112;           // largura/altura do portrait (px)
portrait_padding = 12;            // padding entre portrait e texto

// texto
typed_chars      = 0;             // quantos caracteres já revelados
typing           = true;
nav_cooldown_max = 8;             // proteção contra múltiplos pressionamentos rápidos (frames)
nav_cooldown     = 0;

show_message("ad");


// blink do indicador (quando texto completo)
blink_timer      = 0;
blink_rate       = 30;            // frames para um ciclo

// Se quisermos medir delay em frames (room_speed existe)
if (char_speed <= 0) char_speed = 45;
char_delay_frames = max(1, round(room_speed / char_speed)); // frames entre chars
char_frame_accum  = 0;

// Segurança: se text_full já foi passada antes do Create (possível), define typed_chars apropr.
if (string_length(text) == 0) {
    // caso queira setar depois, manter vazio por enquanto
} else {
    typed_chars = 0;
    typing = true;
}
