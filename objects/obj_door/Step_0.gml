/// @description Verifica a condição para destrancar e atualiza o sprite

// Só executa se a porta ainda estiver trancada.
if (locked) {
    // 1. Garante que o nome da variável foi definido na sala.
    if (required_global_flag != "") {
        
        // 2. Verifica se a variável global com esse nome REALMENTE EXISTE.
        //    Isso previne o jogo de quebrar se você digitar o nome errado.
        if (variable_global_exists(required_global_flag)) {
            
            // 3. Pega o VALOR da variável global usando o NOME dela.
            var _puzzle_completo = variable_global_get(required_global_flag);
            
            // 4. Se o valor for 'true', destranca a porta.
            if (_puzzle_completo == true) {
                locked = false;
                // audio_play_sound(snd_porta_abrindo, 10, false);
            }
        }
    }
} else {
	// 1. Garante que o nome da variável foi definido na sala.
    if (required_global_flag != "") {
        
        // 2. Verifica se a variável global com esse nome REALMENTE EXISTE.
        //    Isso previne o jogo de quebrar se você digitar o nome errado.
        if (variable_global_exists(required_global_flag)) {
            
            // 3. Pega o VALOR da variável global usando o NOME dela.
            var _puzzle_completo = variable_global_get(required_global_flag);
            
            // 4. Se o valor for 'true', destranca a porta.
            if (_puzzle_completo == false) {
                locked = true;
                // audio_play_sound(snd_porta_abrindo, 10, false);
            }
        }
    }
}

// A lógica de mudar o sprite continua a mesma.
image_index = locked ? 0 : 1;