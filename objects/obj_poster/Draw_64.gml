/// @description Desenha a interface do poster quando aberto

if (animation_progress < 0.01) exit;

// --- 1. SETUP INICIAL E FUNDO ---
var sw = display_get_gui_width();
var sh = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.6 * animation_progress);
draw_rectangle(0, 0, sw, sh, false);
draw_set_alpha(animation_progress);

if (animation_progress < 0.95) {
    draw_set_alpha(1);
    exit;
}

// --- 2. PAINEL E SPRITE ---
var pw = round(sw * 0.78);
var ph = round(sh * 0.78);
var px = round((sw - pw) / 2);
var py = round((sh - ph) / 2);

var final_scale = 1; // Inicializa a variável
var center_x = px + pw / 2;
var center_y = py + ph / 2;

if (gui_sprite != noone && sprite_exists(gui_sprite)) {
    var spr_w = sprite_get_width(gui_sprite);
    var spr_h = sprite_get_height(gui_sprite);
    
    var max_w = pw * 0.96;
    var max_h = ph * 0.90;
    var scale_x = max_w / spr_w;
    var scale_y = max_h / spr_h;
    final_scale = min(scale_x, scale_y) * scale;
    
    draw_sprite_ext(gui_sprite, 0, center_x, center_y, final_scale, final_scale, 0, c_white, 1);
}

// --- 3. DESENHO DOS ENDEREÇOS (COM LÓGICA DE CENTRALIZAÇÃO DE BLOCO) ---
if (mode == "addresses" && array_length(addresses_list) > 0) {
    
    // >> PASSO A: CALCULAR LIMITES REAIS DO SPRITE NA TELA
    var final_spr_w = sprite_get_width(gui_sprite) * final_scale;
    var final_spr_h = sprite_get_height(gui_sprite) * final_scale;
    var sprite_x1 = center_x - (final_spr_w / 2);
    var sprite_y1 = center_y - (final_spr_h / 2);

    // >> PASSO B: DEFINIR ÁREA DE CONTEÚDO DENTRO DO SPRITE
    var text_padding = 60;
    var content_x = sprite_x1 + text_padding;
    var content_y = sprite_y1 + text_padding;
    var content_w = final_spr_w - (text_padding * 2);
    var content_h = final_spr_h - (text_padding * 2);

    // >> PASSO C: CALCULAR POSIÇÕES PARA CENTRALIZAÇÃO
    
    // --- CONTROLES DE LAYOUT ---
    var col_count = 2;
    var line_height = 72;                   // << Espaçamento VERTICAL entre linhas
    var column_gap = 60;                    // << Espaçamento HORIZONTAL entre colunas
    // -------------------------

    // 1. Medir a largura de um item (assumindo fonte monoespaçada e texto de mesmo tamanho)
    draw_set_font(fnt_secondary_48); // Precisa setar a fonte ANTES de medir
    var text_item_width = string_width(addresses_list[0]);
    
    // 2. Calcular a largura total do nosso bloco de duas colunas
    var total_block_width = (text_item_width * col_count) + column_gap * (col_count - 1);
    
    // 3. Calcular as posições X para cada coluna, centralizando o bloco
    var block_start_x = content_x + (content_w - total_block_width) / 2;
    var col1_x = block_start_x;
    var col2_x = block_start_x + text_item_width + column_gap;
    
    // 4. Calcular a posição Y inicial para centralização vertical (lógica inalterada)
    var num_rows = ceil(array_length(addresses_list) / col_count);
    var total_text_height = num_rows * line_height;
    var start_y = content_y + (content_h - total_text_height) / 2;
    
    // >> PASSO D: DESENHAR O TEXTO NAS POSIÇÕES CALCULADAS
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(160, 170, 180));
    
    for (var i = 0; i < array_length(addresses_list); i++) {
        var current_col = i % col_count;
        var current_row = floor(i / col_count);
        
        // Define o X baseado na coluna atual
        var draw_x = (current_col == 0) ? col1_x : col2_x;
        var draw_y = start_y + (current_row * line_height);
        
        draw_text(round(draw_x), round(draw_y), addresses_list[i]);
    }
}

// --- 4. RODAPÉ E RESTAURAÇÃO ---
draw_set_font(fnt_secondary_48);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(make_color_rgb(160,160,160));
draw_text(px + pw / 2, py + ph - 12, "E / Esc - Fechar");

draw_set_alpha(1);
draw_set_color(c_white);