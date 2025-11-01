// =======================================================
// DESENHAR MENU DINÂMICO
// =======================================================

// --- 1. Configurações Iniciais ---
draw_set_halign(fa_center);
draw_set_valign(fa_middle); // Manter para o texto, mas o painel será desenhado no top-left

// Definir a fonte ANTES de medir qualquer texto
draw_set_font(fnt_secondary_24);

var padding_x = 32; // Espaçamento horizontal interno do painel
var padding_y = 24; // Espaçamento vertical interno do painel (topo e base)
var item_spacing = 20; // Espaçamento entre os itens do menu

// --- 2. Medir o Conteúdo (Título e Itens do Menu) ---
var max_content_width = 0;
var total_content_height = 0;

// Medir o título
var title_text = menu_label;
var title_width = string_width(title_text);
var title_height = string_height(title_text);

max_content_width = max(max_content_width, title_width);
total_content_height += title_height; // Altura do título

// Adicionar um espaçamento entre o título e o primeiro item do menu (opcional)
total_content_height += 50; // Ou um valor fixo se preferir

// Medir os itens do menu
for (var i = 0; i < array_length(menu_items); i++) {
    var item_text = menu_items[i].text;
    // Se o item selecionado tem um ">", precisamos considerar isso no tamanho
    if (i == selected_index) {
        item_text = "> " + item_text;
    }
    
    var current_item_width = string_width(item_text);
    var current_item_height = string_height(item_text);
    
    max_content_width = max(max_content_width, current_item_width);
    total_content_height += current_item_height;
    
    // Adicionar espaçamento entre os itens (exceto após o último)
    if (i < array_length(menu_items) - 1) {
        total_content_height += item_spacing;
    }
}

// --- 3. Calcular Dimensões Finais do Painel ---
var panel_w = max_content_width + padding_x * 2;
var panel_h = total_content_height + padding_y * 2;

// --- 4. Calcular Posição do Painel (Centralizado) ---
var panel_x = (room_width - panel_w) / 2;
var panel_y = (room_height - panel_h) / 2;

// =======================================================
// SEÇÃO DE DESENHO (DRAW)
// =======================================================

// --- Desenha o Sprite de Fundo do Painel ---
// Certifique-se de que 'spr_menu_background' é o seu sprite de 9-slice configurado
draw_set_alpha(1); // Ou um alpha específico para o fundo do menu
draw_set_color(c_white); // Se o sprite tem cor, c_white geralmente é neutro
draw_sprite_stretched(spr_panel, 0, panel_x, panel_y, panel_w, panel_h);

// --- Desenha o Título e os Itens do Menu ---
// A posição inicial Y para o primeiro elemento de conteúdo (título)
var current_y_draw = panel_y + padding_y;

// Título
draw_set_color(c_white);
draw_text(room_width / 2, current_y_draw + (title_height / 2), title_text); // Centraliza verticalmente o título
current_y_draw += title_height + (30); // Avança Y para o próximo item, incluindo espaçamento extra

// Itens do menu
for (var i = 0; i < array_length(menu_items); i++) {
    var item_text = menu_items[i].text;
    var current_item_height = string_height(item_text); // Re-medir a altura do item para posicionamento exato
    
    if (i == selected_index) {
        draw_set_color(c_yellow);
        draw_text(room_width / 2, current_y_draw + (current_item_height / 2), "> " + item_text);
    } else {
        draw_set_color(c_white);
        draw_text(room_width / 2, current_y_draw + (current_item_height / 2), item_text);
    }
    
    current_y_draw += current_item_height;
    if (i < array_length(menu_items) - 1) {
        current_y_draw += item_spacing;
    }
}

// --- Restaurar Padrões ---
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);