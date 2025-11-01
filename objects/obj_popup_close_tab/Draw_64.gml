// =======================================================
// DESENHAR POPUP DE DICA
// =======================================================

// --- 1. Obter Coordenadas da GUI ---
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// --- 2. Configurações do Painel ---
// O texto que você quer exibir
var text_to_draw = "Aperte Tab para abrir o tablet";
// O "espaçamento interno" do painel
var padding_x = 18;
var padding_y = 12;
// A largura máxima que o painel pode ter (ex: 70% da tela)
var max_w = sw * 0.7;
// A posição Y base (onde ele fica "ancorado" na base da tela)
var py_base = sh - 90; // (ajuste -90 conforme seu layout)

// --- 3. Calcular Dimensões do Texto ---
// !! IMPORTANTE: Defina a fonte ANTES de medir o texto !!
draw_set_font(font_to_use);

var text_width = string_width(text_to_draw);
var text_height = string_height(text_to_draw); // Use string_height para precisão

// --- 4. Calcular Dimensões Finais do Painel ---
// A largura do painel é o tamanho do texto + padding,
// mas limitada pela largura máxima (max_w)
var panel_w = min(max_w, text_width + padding_x * 2);

// A altura do painel é simplesmente a altura do texto + padding
var panel_h = text_height + padding_y * 2;

// --- 5. Calcular Posição Final do Painel ---
// Centralizar horizontalmente
var px = (sw - panel_w) / 2;

// Aplicar a posição base + o offset da sua animação (y_offset)
var py = py_base + y_offset;

// =======================================================
// SEÇÃO DE DESENHO (DRAW)
// =======================================================

// --- Fundo Escurecido ---
draw_set_alpha(alpha * 0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, sw, sh, false);

// --- Painel (Sprite) ---
// Use o sprite que você criou (com 9-slice ativado, de preferência)
draw_set_alpha(alpha * 0.95);
draw_sprite_stretched(spr_panel, 0, px, py, panel_w, panel_h);

// --- Texto ---
draw_set_alpha(alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);

// Desenha o texto exatamente no centro do painel calculado
draw_text(px + (panel_w / 2), py + (panel_h / 2), text_to_draw);

// --- Restaurar Padrões ---
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);