// controlador principal (coordenador de rounds)
if (state == "idle") {
    if (round_timer_frames > 0) {
        round_timer_frames -= 1;
        exit;
    }
    if (auto_start) {
        // iniciar nova rodada
        // escolhe k aleatório 0..array_size-1
		current_k = irandom(array_size - 1);
		global.indice_sorteado = current_k;

		// dispara leitura simultânea
        // 1) array: flash imediato
        var arr_elem = find_array_element(array_id, current_k);
		if (arr_elem != noone && instance_exists(arr_elem)) {
		    signal_target("array:" + string(array_id) + ":" + string(current_k));
		}

        // 2) lista: prepara nodes até k
        current_nodes = [];
        var cur = head_pointer;
        if (!instance_exists(cur)) {
            // fallback: tenta achar primeiro obj_pointer como head
            if (instance_number(obj_pointer) > 0) cur = instance_find(obj_pointer, 0);
        }
        var steps = 0;
        while (cur != noone && instance_exists(cur) && steps <= current_k) {
            array_push(current_nodes, cur);
            // seguir target_inst (supondo que seus ponteiros usem target_inst)
            var next = noone;
            if (variable_instance_exists(cur, "target_inst")) next = cur.target_inst;
            cur = next;
            steps += 1;
        }
        // Agora iniciamos a travessia visual
        current_list_index = 0;
        // start first node flash immediately on next loop
        state = "running_list";
        // set wait for first flash to begin immediately (0)
        list_wait_frames = 0;
    }
}
else if (state == "running_list") {
    if (list_wait_frames > 0) {
        list_wait_frames -= 1;
        exit;
    }
    // se ainda houver nodes a piscar até o k
    if (current_list_index < array_length(current_nodes)) {
        var node_inst = current_nodes[current_list_index];
		if (instance_exists(node_inst)) {
		    if (variable_instance_exists(node_inst, "address")) {
		        signal_target(node_inst.address);
		    }
		}

        // prepara próximo passo: esperar node_flash_frames + inter_gap_frames antes de piscar o próximo
        list_wait_frames = node_flash_frames + inter_gap_frames;
        current_list_index += 1;
    } else {
        // travessia completa
        state = "post_pause";
        round_timer_frames = post_pause_frames;
		global.indice_sorteado = -1;
    }
}
else if (state == "post_pause") {
    if (round_timer_frames > 0) {
        round_timer_frames -= 1;
        exit;
    }
    // fim da rodada: reinicia
    state = "idle";
    // opcional: pequeno atraso antes da próxima
    round_timer_frames = max(1, round(0.2 * _fps));
}
