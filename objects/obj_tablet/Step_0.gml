//ETAPA (STEP)

if (keyboard_check_pressed(vk_tab)) {
    if (!tablet_open && !global.ui_blocked) {
        tablet_open = true;
        global.is_paused = true;
        global.ui_blocked = true;
        input_cooldown = input_cooldown_max;
        
        // Resetar o estado de navegação
        mode = "tabs";
        conceptual_mode = "list";
        conceptual_page = 0;
        content_cursor = 0;
		animation_progress = 0;
    } else if (tablet_open) {
        tablet_open = false;
        global.is_paused = false;
        global.ui_blocked = false;
        input_cooldown = input_cooldown_max;
    }
}

// When closed, do nothing further
if (!tablet_open) {
    if (input_cooldown > 0) input_cooldown -= 1;
    exit;
}

// Input cooldown handling
if (input_cooldown > 0) {
    input_cooldown -= 1;
    exit; // Exit here to prevent any input from being processed during cooldown
}

var target = (is_visible) ? 1 : 0;

animation_progress = lerp(animation_progress, target, animation_speed);

if (animation_progress < 0.95) {
    exit;
}

// Navigation when in tabs area
if (mode == "tabs") {
    if (keyboard_check_pressed(vk_right)) {
        current_tab += 1;
        if (current_tab >= array_length(tabs)) current_tab = 0;
        content_cursor = 0; // Reset cursor when changing tabs
        input_cooldown = input_cooldown_max;
    }
    else if (keyboard_check_pressed(vk_left)) {
        current_tab -= 1;
        if (current_tab < 0) current_tab = array_length(tabs) - 1;
        content_cursor = 0; // Reset cursor when changing tabs
        input_cooldown = input_cooldown_max;
    }
    else if (keyboard_check_pressed(vk_down)) {
        // --- Entra no modo de conteúdo ---
        // Apenas entra se a aba atual tiver algum conteúdo
        if (array_length(contents[current_tab]) > 0 || (tabs[current_tab] == "Conceitual" && array_length(conceptual_items) > 0)) {
            mode = "content";
            content_cursor = 0;
            input_cooldown = input_cooldown_max;
        }
    }
}

// Navigation when inside content pane
else if (mode == "content") {
	// --- Navigation when inside content pane (versão com Conceitual suportado) ---
	var cur_content, len;

	// Se estivermos na aba Conceitual, tratamos de forma especial
	if (tabs[current_tab] == "Conceitual") {
	    cur_content = conceptual_items;
	    len = array_length(cur_content);
		
	    // entrada para navegar a lista (modo "list")
	    if (conceptual_mode == "list") {
	        // UP/DOWN para mover seleção na lista
	        if (keyboard_check_pressed(vk_down)) {
		        // Move down the content list, but don't go past the last item
		        if (content_cursor < len - 1) {
		            content_cursor += 1;
		            input_cooldown = input_cooldown_max;
		        }
		    }
		    else if (keyboard_check_pressed(vk_up)) {
		        if (content_cursor > 0) {
		            // Se não estiver no topo, apenas move o cursor para cima
		            content_cursor -= 1;
		        } else {
		            // --- Se já estiver no topo (cursor é 0), volta para a seleção de abas ---
		            mode = "tabs";
		        }
		        input_cooldown = input_cooldown_max;
		    }
			
	        // ENTER => entra no item (modo leitura)
	        else if (keyboard_check_pressed(vk_enter)) {
	            if (len > 0) {
	                conceptual_mode = "read";
	                conceptual_page = 0;
	                input_cooldown = input_cooldown_max;
	            }
	        }
	        // Left/Right (opcional): aqui não trocamos abas, mantemos comportamento de somente lista
	    }
	    // modo leitura: LEFT/RIGHT para navegar páginas, ENTER sai e volta pra lista
	    else if (conceptual_mode == "read") {
			var cur_concept = concept_get(conceptual_items[content_cursor].id);
		
	        var pages = cur_concept.pages;
	        var pcount = array_length(pages);

	        if (keyboard_check_pressed(vk_right)) {
	            if (conceptual_page < pcount - 1) conceptual_page += 1;
	            input_cooldown = input_cooldown_max;
	        }
	        else if (keyboard_check_pressed(vk_left)) {
	            if (conceptual_page > 0) conceptual_page -= 1;
	            input_cooldown = input_cooldown_max;
	        }
	        // Enter: sair do modo leitura e voltar para lista (mantendo o mesmo item selecionado)
	        else if (keyboard_check_pressed(vk_enter)) {
	            conceptual_mode = "list";
	            input_cooldown = input_cooldown_max;
	        }
	    }

	    // garantir content_cursor em range (caso len tenha mudado)
	    if (content_cursor < 0) content_cursor = 0;
	    if (content_cursor >= len) content_cursor = max(0, len - 1);
	
	} else {

	    cur_content = contents[current_tab];
	    len = array_length(cur_content);
	
		// Pega cur_content e tamanho da lista baseado na aba
	
		if (tabs[current_tab] == "Objetivos") {
			len = array_length(tablet_get_objectives_for_day(global.cur_day));
		}
	

	    if (keyboard_check_pressed(vk_down)) {
	        // Move down the content list, but don't go past the last item
	        if (content_cursor < len - 1) {
	            content_cursor += 1;
	            input_cooldown = input_cooldown_max;
	        }
	    }
	    else if (keyboard_check_pressed(vk_up)) {
	        if (content_cursor > 0) {
	            // Se não estiver no topo, apenas move o cursor para cima
	            content_cursor -= 1;
	        } else {
	            // --- Se já estiver no topo (cursor é 0), volta para a seleção de abas ---
	            mode = "tabs";
	        }
	        input_cooldown = input_cooldown_max;
	    }
	
		if (tabs[current_tab] == "Opções") {
	
			if (input_cooldown <= 0) {
			    // verificar ENTER (tecla principal e numpad)
			    if (keyboard_check_pressed(vk_enter)) {
				
					var item = options_items[content_cursor];

					if (item.use_id) item.action(id) else item.action();

			        input_cooldown = input_cooldown_max;
			    }
			}
		
		}
	}
}