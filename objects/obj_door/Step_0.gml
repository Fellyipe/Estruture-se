/// @description Verifica a condição para destrancar e atualiza o sprite

if(use_flag_list) { 
	
	// Assumimos que a porta só abre se TODAS as flags na lista forem verdadeiras.
    var _all_flags_are_true = true;
    
    // Se a lista estiver vazia, a condição não pode ser satisfeita.
    if (array_length(flag_list) == 0) {
        _all_flags_are_true = false;
    } else {
        // Percorre cada nome de flag na lista
        for (var i = 0; i < array_length(flag_list); i++) {
            var _flag_name = flag_list[i];
            
            // Verifica se a flag global existe e se o valor dela é 'false'
            if (!variable_global_exists(_flag_name) || variable_global_get(_flag_name) == false) {
                _all_flags_are_true = false;
                break; // Se uma única flag for falsa, já podemos parar a verificação.
            }
        }
    }
    
    // Atualiza o estado 'locked' com base no resultado da verificação da lista
    // Se todas as flags são verdadeiras, locked = false.
    // Se pelo menos uma for falsa, locked = true.
    locked = !_all_flags_are_true;	
	
} else {
	if (locked) {
	    if (required_global_flag != "") {
        
	        if (variable_global_exists(required_global_flag)) {
            
	            var _puzzle_completo = variable_global_get(required_global_flag);
            
	            if (_puzzle_completo == true) {
	                locked = false;
					audio_play_sound(snd_door_opened, 0, false, 1, 0, 1);
	            }
	        }
	    }
	} else {
	    if (required_global_flag != "") {
        
	        if (variable_global_exists(required_global_flag)) {            
	            var _puzzle_completo = variable_global_get(required_global_flag);
            
	            if (_puzzle_completo == false) {
	                locked = true;
	            }
	        }
	    }
	}
}

if(global.all_doors_opened) locked = false;

// A lógica de mudar o sprite continua a mesma.
image_index = locked ? 0 : 1;