// desenha a faixa no centro-baixo da GUI

// coordenadas GUI
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// --- 1. Configurações e Medições ---
var padding_x = 18;
var padding_y = 12;
var max_w = sw * 0.7;

// !! IMPORTANTE: Defina a fonte ANTES de medir o texto !!
draw_set_font(font_to_use);
var text_width = string_width(text);
var text_height = string_height(text); // Mede a altura real da fonte

// --- 2. Calcular Dimensões do Painel ---
var panel_w = min(max_w, text_width + padding_x * 2);
// A altura do painel agora se baseia na altura do texto + padding
var panel_h = text_height + padding_y * 2; 

// --- 3. Calcular Posição do Painel ---
var px = (sw - panel_w) / 2;
var py_base = sh - 90; // posição base (ajuste -90 conforme layout)
var py = py_base + y_offset; // (y_offset de sua animação)


// ===================================
// SEÇÃO DE DESENHO
// ===================================

// --- Fundo Escurecido (Opcional) ---
// (Você não tinha isso no código original, mas tinha no outro,
// então talvez queira manter)
// draw_set_alpha(alpha * 0.6);
// draw_set_color(c_black);
// draw_rectangle(0, 0, sw, sh, false);


// --- Desenhar Fundo do Painel (com Sprite) ---
// Substitua 'spr_seu_painel_aqui' pelo nome do seu sprite
draw_set_color(c_white); // Garante que o sprite não seja "tintado"
draw_set_alpha(alpha * 0.95); // Aplica o alpha ao sprite
draw_sprite_stretched(spr_panel, 0, px, py, panel_w, panel_h);


// --- Texto ---
draw_set_alpha(alpha); // Alpha normal para o texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);
// Desenha o texto perfeitamente no centro do painel
draw_text(px + (panel_w / 2), py + (panel_h / 2), text);


// --- Restaurar Padrões ---
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);