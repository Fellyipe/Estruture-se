// DRAW_GUI
if (!tablet_open) exit;

// ===================================================================
// SETUP INICIAL E CONFIGURAÇÃO DE SPRITES
// ===================================================================

// >> Defina aqui os sprites da sua UI
//var spr_tablet_body = spr_tablet_base; // O sprite da moldura/corpo do tablet
var spr_tab_active_9slice = spr_panel_active;
var spr_tab_inactive_9slice = spr_panel;
var spr_highlight_9slice = spr_panel_highlight;

// >> Camada 1: Coordenadas do corpo EXTERNO do tablet
var sw = display_get_gui_width();
var sh = display_get_gui_height();
var tablet_pw = round(sw * 0.7);
var tablet_ph = round(sh * 0.72);
var tablet_px = (sw - tablet_pw) / 2;
var tablet_py = (sh - tablet_ph) / 2;

// >> Camada 2: Coordenadas da TELA INTERNA, dentro da moldura
var bezel_size = 40; // A distância de 40 pixels da borda que você mencionou
var screen_px = tablet_px + bezel_size;
var screen_py = tablet_py + bezel_size;
var screen_pw = tablet_pw - (bezel_size * 2);
var screen_ph = tablet_ph - (bezel_size * 2);

// >> O padding agora é relativo à borda da tela interna
var padding = 16;
var inactive_text_color = make_color_rgb(160, 170, 180);

// ===================================================================
// FUNDO E MOLDURA PRINCIPAL
// ===================================================================

draw_set_color(c_black);
draw_set_alpha(0.6 * animation_progress); // O fundo aparece suavemente junto com o painel.
draw_rectangle(0, 0, sw, sh, false);

draw_set_alpha(1);

if (animation_progress  < 0.95) {
    exit;
}



// >> NOVO: Desenha a moldura do tablet usando as coordenadas EXTERNAS
draw_sprite_stretched(spr_tablet_body, 0, tablet_px, tablet_py, tablet_pw, tablet_ph);

// ===================================================================
// BARRA SUPERIOR E TÍTULO (Agora dentro da TELA)
// ===================================================================

var top_h = 40;
// Não precisamos mais desenhar um fundo para a barra superior, pois a "tela" já é o fundo.

// >> O título agora é centralizado dentro da LARGURA DA TELA (screen_pw)
draw_set_font(label_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(label_color);
draw_text(screen_px + screen_pw / 2, screen_py + top_h / 2, "Aether Tablet X5 Pro");

// ===================================================================
// ABAS (TABS) (Agora dentro da TELA)
// ===================================================================

// >> As coordenadas das abas agora partem da posição da TELA (screen_px, screen_py)
var tab_bar_y = screen_py + top_h;
var tab_h = 36;
var tab_w = 150;
var tab_x_start = screen_px + padding;
var tab_gap = 8;

for (var i = 0; i < array_length(tabs); ++i) {
    var tx = tab_x_start + i * (tab_w + tab_gap);
    var ty = tab_bar_y;
    
    if (i == current_tab) {
        draw_sprite_stretched(spr_tab, 0, tx, ty, tab_w, tab_h);
        draw_set_color(label_color);
    } else {
        draw_sprite_stretched(spr_tab, 1, tx, ty, tab_w, tab_h);
        draw_set_color(inactive_text_color);
    }
    
    draw_set_font(label_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(tx + tab_w / 2, ty + tab_h / 2, tabs[i]);
}

// ===================================================================
// ÁREA DE CONTEÚDO (Agora dentro da TELA)
// ===================================================================

var content_start_y = tab_bar_y + tab_h + padding;
// >> As coordenadas e dimensões do conteúdo são relativas à TELA
var content_x = screen_px + padding;
var content_y = content_start_y;
var content_w = screen_pw - (padding * 2);
var line_h = 28;
var cur_content = contents[current_tab];
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// A lógica de desenho de cada aba permanece a mesma, pois ela já usa as
// variáveis (content_x, content_y, content_w) que acabamos de recalcular.
if (tabs[current_tab] == "Conceitual") {
    // (A sua lógica para a aba "Conceitual" permanece inalterada aqui...)
    var left_w = 240;
    var list_x = content_x;
    var list_y = content_y;
    var list_w = left_w;
    var items = conceptual_items;
    //for (var i = 0; i < array_length(items); ++i) {
    //    var ly = list_y + i * line_h;
    //    //if (mode == "content" && conceptual_mode == "list" && i == content_cursor) {
    //    if (mode == "content" && i == content_cursor) {
    //        // Destaque da lista com sprite 9-slice
    //        draw_sprite_stretched(spr_highlight_9slice, 0, list_x - 8, ly - 1, list_w, line_h);
    //        draw_set_color(label_color);
    //    } else {
    //        draw_set_color(inactive_text_color);
    //    }
    //    draw_text(list_x, ly, items[i].title);
    //}
	
	// >> NOVO: Calcular quantos itens cabem na tela
    var content_h = screen_ph - (content_y - screen_py) - padding; // Altura útil da área de conteúdo
    var items_visiveis = floor(content_h / line_h); // Quantos itens de altura 'line_h' cabem aqui

    // >> NOVO: O loop agora começa do item 'conceptual_scroll_top' e desenha apenas os itens visíveis
    var end_index = min(array_length(items), conceptual_scroll_top + items_visiveis);

    for (var i = conceptual_scroll_top; i < end_index; ++i) {
        // >> MUDANÇA: A posição 'y' agora é relativa ao topo da lista, não ao índice absoluto 'i'
        var relative_i = i - conceptual_scroll_top;
        var ly = list_y + relative_i * line_h;

        // O resto da lógica de destaque e desenho permanece igual
        if (mode == "content" && i == content_cursor) {
            draw_sprite_stretched(spr_highlight_9slice, 0, list_x - 8, ly - 1, list_w, line_h);
            draw_set_color(label_color);
        } else {
            draw_set_color(inactive_text_color);
        }
		
		var is_unread = concept_is_unread(items[i].id);
		// desenhar pequeno marcador à esquerda caso não-lido
		if (is_unread) {
		    // preferível usar sprite (spr_unread_dot). Se não existir, desenhamos um círculo simples
		    draw_set_color(new_concept_color);
		}
        draw_text(list_x, ly, items[i].title);
		draw_set_color(label_color);
    }
	
	
	
	
    var read_x = list_x + list_w + padding;
    var read_w = content_w - list_w - padding;
    var read_y = list_y;
    if (conceptual_mode == "read" && array_length(items) > 0) {
        var cur_concept = concept_get(items[content_cursor].id);
        var page_text = cur_concept.pages[conceptual_page];
        draw_set_color(tab_active_color);
        draw_text(read_x, read_y, items[content_cursor].title);
        draw_set_color(label_color);
        var body_y = read_y + 36;
        var line_sep = string_height("M") + 8;
        var wrap_w = read_w - padding;
		
		if (page_text != current_text_cache) {
	        // Se mudou, atualizamos o cache
	        current_text_cache = page_text;
        
	        // E criamos um NOVO elemento Scribble com o texto atual
	        scribble_element = scribble(page_text);
        
	        // AQUI você define o espaçamento entre linhas e outras propriedades!
	        // O valor é em pixels. O padrão é 0.
	        // Um valor de 8, por exemplo, adiciona 8 pixels de espaço extra.
	        //scribble_element.set_line_height(8, true); // O 'true' significa que o valor é em pixels
			
	        // Você também pode definir a largura máxima (wrap) aqui
	        
			//scribble_element.line_spacing("200%");
			scribble_element.wrap(wrap_w);
			scribble_element.line_spacing("125%");
			scribble_element.starting_format("fnt_secondary_18", #C7D4E1)
			

	    }
		
        //draw_text_ext(read_x, body_y, page_text, line_sep, wrap_w);
        //draw_text_scribble_ext(read_x, body_y, page_text, wrap_w);
		if (scribble_element != noone) {
	        scribble_element.draw(read_x, body_y);
	    }
		
        draw_set_halign(fa_right);
        draw_set_color(inactive_text_color);
        draw_text_scribble(screen_px + screen_pw - padding, screen_py + screen_ph - 4 * padding, "[spr_arrow_tiny, 0] [spr_arrow_tiny, 1] " + string(conceptual_page + 1) + " / " + string(array_length(cur_concept.pages)));
    }

} else if (tabs[current_tab] == "Objetivos") {
    
    //var day_items = tablet_get_objectives_for_day(global.cur_day);
    var day_items = tablet_get_objectives_for_room();
	var all_done = true;
	
    for (var j = 0; j < array_length(day_items); ++j) {
        var ly = content_y + j * line_h;
        
        // Lógica de destaque da linha (inalterada)
        if (mode == "content" && j == content_cursor) {
            draw_sprite_stretched(spr_highlight_9slice, 0, content_x - 8, ly, content_w + 8, line_h);
            draw_set_color(label_color);
        } else {
            draw_set_color(label_color);
        }
        
        // >> MUDANÇA: Lógica do checkbox com sprites
        var it = day_items[j];
        var done = tablet_is_objective_complete(it.flag);
		
		if (!done) all_done = false;
        
        // 2. Desenha o sprite do checkbox
        // (Recomendo que a origem do sprite seja "Middle Left" para alinhar bem)
        var checkbox_x = content_x;
        var checkbox_y = ly + (line_h / 2); // Centraliza o sprite verticalmente na linha
		//var fnt_oficial = global.fnt_oficial;
		
		scribble_font_set_default("fnt_secondary_18");
		if done draw_text_scribble(checkbox_x, checkbox_y, "[fa_middle][spr_checkbox, 0]  " + it.label) else draw_text_scribble(checkbox_x, checkbox_y, "[fa_middle][spr_checkbox, 1]  " + it.label);
        
		
		//if (array_length(day_items) > 0 && all_done) {
        //if (!variable_instance_exists(self, "objectives_popup_shown") || !objectives_popup_shown) {
	    //        // mostra popup uma única vez
	    //        show_popup("Nível concluído!", 3);
		//		audio_play_sound(snd_puzzle_solved, 0, false, 1, 0, 1);
	    //        objectives_popup_shown = true;
	    //    }
	    //} else {
	    //    // Se nem todos estão completos, permitimos que o popup seja mostrado
	    //    // futuramente quando todos forem concluídos
	    //    objectives_popup_shown = false;
	    //}
        
        // 3. Calcula a posição do texto para ficar ao lado do sprite
        //var text_x = checkbox_x + sprite_get_width(spr_checkbox) + 8; // Adiciona 8 pixels de espaço
        
        //// 4. Desenha o texto do objetivo
        //draw_set_halign(fa_left);
        //draw_set_valign(fa_middle); // Alinha o texto verticalmente com o sprite
        //draw_text(text_x, checkbox_y, it.label);
        //draw_set_valign(fa_top); // Reseta o alinhamento vertical para o padrão
    }
} else {
    // ... seu código para outras abas ...
    for (var j = 0; j < array_length(cur_content); ++j) {
        var ly = content_y + j * line_h;
        if (mode == "content" && j == content_cursor) {
            draw_sprite_stretched(spr_highlight_9slice, 0, content_x - 8, ly - 4, content_w + 8, line_h);
            draw_set_color(label_color);
        } else {
            draw_set_color(label_color);
        }
        draw_text(content_x, ly, cur_content[j]);
    }
}


// ===================================================================
// RODAPÉ (FOOTER) (Agora dentro da TELA)
// ===================================================================

// >> O texto de ajuda agora é posicionado no canto inferior direito da TELA
draw_set_font(label_font);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(inactive_text_color);
//draw_text(screen_px + screen_pw - padding, screen_py + screen_ph - 8, "← → ↓ ↑ : Navegar dentro e fora das abas - Enter : Entrar/Sair do modo de leitura - Tab : Fechar");
draw_text_scribble(screen_px + screen_pw / 2, screen_py + screen_ph - 8, "[spr_arrow_tiny, 0] [spr_arrow_tiny, 1] [spr_arrow_tiny, 2] [spr_arrow_tiny, 3] : Navegar - Enter : Ler/Voltar - Tab : Fechar");
// ===================================================================
// RESTAURAR PADRÕES
// ===================================================================
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fnt_menu);