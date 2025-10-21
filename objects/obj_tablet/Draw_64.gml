////// DRAW_GUI
////if (!tablet_open) exit;

////// screen dimensions
////var sw = display_get_gui_width();
////var sh = display_get_gui_height();

////// panel dimensions (centered)
////var pw = sw * 0.7;
////var ph = sh * 0.72;
////var px = (sw - pw) / 2;
////var py = (sh - ph) / 2;

////// draw dim background overlay
////draw_set_alpha(0.6);
////draw_set_color(c_black);
////draw_rectangle(0,0,sw,sh,false);
////draw_set_alpha(1);

////// panel background
////draw_set_color(panel_color);
////draw_rectangle(px, py, px+pw, py+ph, false);

////// top bar
////var top_h = 40;
////draw_set_color(bg_color);
////draw_rectangle(px, py, px+pw, py+top_h, false);

////// title
////draw_set_font(label_font);
////draw_set_halign(fa_center);
////draw_set_valign(fa_middle);
////draw_set_color(label_color);
////draw_text(px + pw/2, py + top_h/2, "Tablet - VortexPad X10 Pro");

////var tab_bar_h = 36; // Altura da área das abas
////var tab_w = 150;    // Largura de cada aba
////var tab_h = 28;     // Altura de cada aba
////var tab_x_start = px + 8;
////var tab_y = py + top_h + 4;
////var tab_gap = 8;

////for (var i = 0; i < array_length(tabs); ++i) {
////    var tx = tab_x_start + i * (tab_w + tab_gap);
    
////    // background for active/inactive
////    if (i == current_tab) draw_set_color(tab_active_color);
////    else draw_set_color(tab_inactive_color);
////    draw_rectangle(tx, tab_y, tx + tab_w, tab_y + tab_h, false);
    
////    // label
////    draw_set_color(c_black);
////    draw_set_font(label_font);
////    draw_set_halign(fa_center);
////    draw_set_valign(fa_middle);
////    draw_text(tx + tab_w/2, tab_y + tab_h/2, tabs[i]);
////}

////var content_x = px + 16;
////var content_y = py + top_h + tab_bar_h + 12; // Abaixo da barra de título E da barra de abas
////var content_w = pw - 32;
////var content_h = ph - top_h - tab_bar_h - 28;

////// header of content
////draw_set_color(label_color);
////draw_set_halign(fa_left);
////draw_set_font(label_font);
//////draw_text(content_x, content_y - 6, tabs[current_tab]);

////// draw content list
////var cur_content = contents[current_tab];
////var line_h = 26;
////// ===== Desenho específico para a aba Conceitual =====
////if (tabs[current_tab] == "Conceitual") {
////    // dimensões
////    var left_w = 240; // largura da coluna esquerda (lista)
////    var list_x = content_x;
////    var list_y = content_y;
////    var list_w = left_w;
////    var list_h = content_h;

////    // desenhar coluna da lista (fundo leve)
////    draw_set_color(make_color_rgb(22,26,30));
////    draw_rectangle(list_x - 8, list_y - 6, list_x + list_w - 8, list_y + list_h, false);

////    // itens da lista
////    var items = conceptual_items;
////    //var line_h = 28;
////    for (var i = 0; i < array_length(items); ++i) {
////        var ly = list_y + i * line_h;
////        if (mode == "content" && conceptual_mode == "list" && i == content_cursor) {
////            // destaque da seleção
////            draw_set_color(tab_active_color);
////            draw_rectangle(list_x - 6, ly - 4, list_x + list_w - 16, ly + line_h - 6, false);
////            draw_set_color(c_black);
////        } else {
////            draw_set_color(label_color);
////        }
////        draw_set_halign(fa_left);
////        draw_set_font(label_font);
////        draw_text(list_x, ly, items[i].title);
////    }

////    // área de leitura / preview (centro-direita)
////    var read_x = list_x + list_w + 16;
////    var read_w = content_w - list_w - 24;
////    var read_y = list_y;
////    var read_h = content_h;

////    // desenhar borda/fundo da área de leitura
////    draw_set_color(make_color_rgb(14,18,22));
////    draw_rectangle(read_x - 8, read_y - 6, read_x + read_w - 8, read_y + read_h, false);

////    // Se estivermos em modo de leitura, desenhar a página atual
////    if (conceptual_mode == "read" && array_length(items) > 0) {
////		var cur_concept = concept_get(items[content_cursor].id);
		
////        var pages = cur_concept.pages;
////        var page_count = array_length(pages);
////        var page_text = pages[conceptual_page];

////        // título do item (no topo da área de leitura)
////        draw_set_color(tab_active_color);
////        draw_set_font(label_font);
////        draw_set_halign(fa_left);
////        draw_text(read_x, read_y, items[content_cursor].title);

////        // corpo do texto (simples, sem word-wrap avançado)
////        draw_set_color(label_color);
////        draw_set_font(label_font);
////        // posiciona o texto um pouco abaixo do título
////        var body_y = read_y + 34;

////        // Use draw_text_ext se quiser wrap; aqui vamos usar draw_text e controlar y por linhas simples.
////        // Se o texto for longo, prefira quebrar em páginas manualmente.
////        var separation = -1; // -1 usa o espaçamento padrão da fonte
////        var wrap_width = read_w - 16; // Largura da área de leitura com uma pequena margem
////        draw_text_ext(read_x, body_y, page_text, separation, wrap_width);

////        // rodapé de paginação
////        draw_set_color(make_color_rgb(160,160,160));
////        draw_set_halign(fa_right);
////        draw_text(read_x + read_w - 12, read_y + read_h - 12, string(conceptual_page + 1) + " / " + string(page_count));
////    }
////    else {
////        // no modo lista: mostrar pré-visualização curta do item selecionado (por exemplo primeira página)
////        if (array_length(items) > 0) {
////			var cur_concept = concept_get(items[content_cursor].id);
			
////            var preview = cur_concept.pages[0];
////            draw_set_color(label_color);
////            draw_set_font(label_font);
////            draw_set_halign(fa_left);
            
////			var separation = -1;
////            var wrap_width = read_w - 16;
////            draw_text_ext(read_x, read_y + 8, preview, separation, wrap_width);
////        }
////    }
////} else if (tabs[current_tab] == "Objetivos") {
////	var day_items = tablet_get_objectives_for_day(global.cur_day);
////	for (var j = 0; j < array_length(day_items); ++j) {
////		var it = day_items[j];
////		var ly = content_y + j * line_h;
////		var done = tablet_is_objective_complete(it.flag);
////		var checkbox = (done ? "V " : "F ");
////	    // highlight selected item when in content mode
////	    if (mode == "content" && j == content_cursor) {
////	        draw_set_color(tab_active_color);
////	        draw_rectangle(content_x - 6, ly - 4, content_x + content_w - 8, ly + line_h - 6, false);
////	        draw_set_color(c_black);
////	    } else {
////	        draw_set_color(label_color);
////	    }
////	    draw_set_halign(fa_left);
////	    draw_text(content_x, ly, checkbox + cur_content[j]);
////	}
////} else {
////	for (var j = 0; j < array_length(cur_content); ++j) {
////	    var ly = content_y + j * line_h;
////	    // highlight selected item when in content mode
////	    if (mode == "content" && j == content_cursor) {
////	        draw_set_color(tab_active_color);
////	        draw_rectangle(content_x - 6, ly - 4, content_x + content_w - 8, ly + line_h - 6, false);
////	        draw_set_color(c_black);
////	    } else {
////	        draw_set_color(label_color);
////	    }
////	    draw_set_halign(fa_left);
////	    draw_text(content_x, ly, cur_content[j]);
////	}
////}


////// footer help text
////draw_set_halign(fa_center);
////draw_set_valign(fa_bottom);
////draw_set_color(make_color_rgb(160,160,160));
////draw_text(px + pw/2, py + ph - 8, "← → : mudar abas • ↓ : entrar • ↑ : voltar • Tab/Esc : fechar");

////// restore defaults
////draw_set_alpha(1);
////draw_set_color(c_white);
////draw_set_font(fnt_menu);










//// DRAW_GUI
//if (!tablet_open) exit;

//// ===================================================================
//// SETUP INICIAL
//// ===================================================================

//var sw = display_get_gui_width();
//var sh = display_get_gui_height();
//var pw = sw * 0.7;
//var ph = sh * 0.72;
//var px = (sw - pw) / 2;
//var py = (sh - ph) / 2;
//var padding = 16;
//var inactive_text_color = make_color_rgb(160, 170, 180);
//var border_color = make_color_rgb(80, 85, 90);
//var divider_color = make_color_rgb(50, 55, 60);

//// ===================================================================
//// FUNDO E PAINEL PRINCIPAL
//// ===================================================================

//draw_set_alpha(0.6);
//draw_set_color(c_black);
//draw_rectangle(0, 0, sw, sh, false);
//draw_set_alpha(1);
//draw_set_color(panel_color);
//draw_rectangle(px, py, px + pw, py + ph, false);
//draw_set_color(border_color);
//draw_rectangle(px, py, px + pw, py + ph, true);

//draw_sprite_stretched(spr_tablet, 0, px, py, pw, ph);

//// ===================================================================
//// BARRA SUPERIOR E TÍTULO
//// ===================================================================

//var top_h = 40;
//draw_set_color(bg_color);
//draw_rectangle(px, py, px + pw, py + top_h, false);
//draw_set_color(divider_color);
//draw_line(px, py + top_h, px + pw, py + top_h);
//draw_set_font(label_font);
//draw_set_halign(fa_center);
//draw_set_valign(fa_middle);
//draw_set_color(label_color);
//draw_text(px + pw / 2, py + top_h / 2, "Tablet - VortexPad X10 Pro");

//// ===================================================================
//// ABAS (TABS)
//// ===================================================================

//var tab_bar_y = py + top_h;
//var tab_h = 36;
//var tab_w = 150;
//var tab_x_start = px + padding;
//var tab_gap = 8;

//for (var i = 0; i < array_length(tabs); ++i) {
//    var tx = tab_x_start + i * (tab_w + tab_gap);
//    if (i == current_tab) {
//        draw_set_color(label_color);
//        draw_set_font(label_font);
//        draw_set_halign(fa_center);
//        draw_set_valign(fa_middle);
//        draw_text(tx + tab_w / 2, tab_bar_y + tab_h / 2, tabs[i]);
//        draw_set_color(tab_active_color);
//        draw_line_width(tx, tab_bar_y + tab_h - 1, tx + tab_w, tab_bar_y + tab_h - 1, 3);
//    } else {
//        draw_set_color(inactive_text_color);
//        draw_set_font(label_font);
//        draw_set_halign(fa_center);
//        draw_set_valign(fa_middle);
//        draw_text(tx + tab_w / 2, tab_bar_y + tab_h / 2, tabs[i]);
//    }
//}
//var content_start_y = tab_bar_y + tab_h + 1;
//draw_set_color(divider_color);
//draw_line(px, content_start_y, px + pw, content_start_y);

//// ===================================================================
//// ÁREA DE CONTEÚDO
//// ===================================================================

//var content_x = px + padding;
//var content_y = content_start_y + padding;
//var content_w = pw - padding * 2;
//var content_h = (py + ph) - content_y - padding;
//var line_h = 28;
//var cur_content = contents[current_tab];
//draw_set_halign(fa_left);
//draw_set_valign(fa_top);

//// ===================================================================
//// RODAPÉ (FOOTER)
//// ===================================================================

//draw_set_font(label_font);
//draw_set_halign(fa_right);
//draw_set_valign(fa_bottom);
//draw_set_color(inactive_text_color);
//draw_text(px + pw - padding, py + ph - 8, "← → : Mudar Abas • ↓ : Entrar • ↑ : Voltar • Tab/Esc : Fechar");

//// ===================================================================
//// RESTAURAR PADRÕES
//// ===================================================================
//draw_set_alpha(1);
//draw_set_color(c_white);
//draw_set_font(fnt_menu);











// DRAW_GUI
if (!tablet_open) exit;

// ===================================================================
// SETUP INICIAL E CONFIGURAÇÃO DE SPRITES
// ===================================================================

// >> Defina aqui os sprites da sua UI
//var spr_tablet_body = spr_tablet_base; // O sprite da moldura/corpo do tablet
var spr_tab_active_9slice = spr_panel;
var spr_tab_inactive_9slice = spr_panel;
var spr_highlight_9slice = spr_panel;

// >> Camada 1: Coordenadas do corpo EXTERNO do tablet
var sw = display_get_gui_width();
var sh = display_get_gui_height();
var tablet_pw = sw * 0.7;
var tablet_ph = sh * 0.72;
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

// Fundo escurecido
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, sw, sh, false);
draw_set_alpha(1);

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
draw_text(screen_px + screen_pw / 2, screen_py + top_h / 2, "Tablet - VortexPad X10 Pro");

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
    for (var i = 0; i < array_length(items); ++i) {
        var ly = list_y + i * line_h;
        if (mode == "content" && conceptual_mode == "list" && i == content_cursor) {
            // Destaque da lista com sprite 9-slice
            draw_sprite_stretched(spr_highlight_9slice, 0, list_x - 8, ly - 4, list_w, line_h);
            draw_set_color(label_color);
        } else {
            draw_set_color(inactive_text_color);
        }
        draw_text(list_x, ly, items[i].title);
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
        draw_text_ext(read_x, body_y, page_text, line_sep, wrap_w);
        draw_set_halign(fa_right);
        draw_set_color(inactive_text_color);
        draw_text(screen_px + screen_pw - padding, screen_py + screen_ph - padding, string(conceptual_page + 1) + " / " + string(array_length(cur_concept.pages)));
    }

} else if (tabs[current_tab] == "Objetivos") {
    
    var day_items = tablet_get_objectives_for_day(global.cur_day);
    for (var j = 0; j < array_length(day_items); ++j) {
        var ly = content_y + j * line_h;
        
        // Lógica de destaque da linha (inalterada)
        if (mode == "content" && j == content_cursor) {
            draw_sprite_stretched(spr_highlight_9slice, 0, content_x - 8, ly - 4, content_w + 8, line_h);
            draw_set_color(label_color);
        } else {
            draw_set_color(label_color);
        }
        
        // >> MUDANÇA: Lógica do checkbox com sprites
        var it = day_items[j];
        var done = tablet_is_objective_complete(it.flag);
        
        // 2. Desenha o sprite do checkbox
        // (Recomendo que a origem do sprite seja "Middle Left" para alinhar bem)
        var checkbox_x = content_x;
        var checkbox_y = ly + (line_h / 2); // Centraliza o sprite verticalmente na linha
		//var fnt_oficial = global.fnt_oficial;
		
		scribble_font_set_default("fnt_oficial");
		if done draw_text_scribble(checkbox_x, checkbox_y, "[fa_middle][spr_checkbox, 0]  " + it.label) else draw_text_scribble(checkbox_x, checkbox_y, "[fa_middle][spr_checkbox, 1]  " + it.label);
        
        
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
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_set_color(inactive_text_color);
draw_text(screen_px + screen_pw - padding, screen_py + screen_ph - 8, "← → : Mudar Abas • ↓ : Entrar • ↑ : Voltar • Tab/Esc : Fechar");

// ===================================================================
// RESTAURAR PADRÕES
// ===================================================================
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fnt_menu);