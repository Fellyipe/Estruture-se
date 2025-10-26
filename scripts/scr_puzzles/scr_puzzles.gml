/// return: true/false
//function check_sequence(head_id, target_list, use_nodes = false) {
//    // validações básicas
//    if (!instance_exists(head_id)) return false;
//    if (!ds_exists(target_list, ds_type_list)) return false;

//    // traversal estático (seguir target_inst) e detectar ciclo
//    var visited_ids = ds_list_create();
//    var addrs_traversed = ds_list_create();
//    var cur = head_id;
//    var iteration_limit = 10000;
//    var iter = 0;
//    while (cur != noone && instance_exists(cur) && iter < iteration_limit) {
//        // detecta ciclo (mesma instância repetida)
//        if (ds_list_find_index(visited_ids, cur) != -1) {
//            ds_list_destroy(visited_ids);
//            ds_list_destroy(addrs_traversed);
//            return false;
//        }
//        ds_list_add(visited_ids, cur);

//        // guarda address (se existir) — senão guarda "" (string vazia)
//        var addr_val = "";
//        if (variable_instance_exists(cur, "address")) {
//            addr_val = cur.address; // pode ser número ou string conforme seu design
//        }
//        ds_list_add(addrs_traversed, addr_val);

//        // avança
//        var next = noone;
//        if (variable_instance_exists(cur, "target_inst")) next = cur.target_inst;
//        cur = next;
//        iter += 1;
//    }
//    if (iter >= iteration_limit) {
//        // safeguard: iteração demasiado grande
//        ds_list_destroy(visited_ids);
//        ds_list_destroy(addrs_traversed);
//        return false;
//    }

//    // comparar tamanhos
//    if (ds_list_size(addrs_traversed) != ds_list_size(target_list)) {
//        ds_list_destroy(visited_ids);
//        ds_list_destroy(addrs_traversed);
//        return false;
//    }

//    // comparar cada elemento e checar energized nos IDs correspondentes
//    var size = ds_list_size(addrs_traversed);
//    for (var i = 0; i < size; ++i) {
//        var want_addr = ds_list_find_value(target_list, i);
//        var got_addr  = ds_list_find_value(addrs_traversed, i);

//        // comparação robusta: se qualquer um for string, comparar por string,
//        // senão comparar numericamente
//        var equal = false;
//        if (is_string(want_addr) || is_string(got_addr)) {
//            equal = (string(want_addr) == string(got_addr));
//        } else {
//            // tratar como números (ou valores que se comparam numericamente)
//            equal = (real(want_addr) == real(got_addr));
//        }
//        if (!equal) {
//            ds_list_destroy(visited_ids);
//            ds_list_destroy(addrs_traversed);
//            return false;
//        }

//        // checar energized do node correspondente
//        var node_id = ds_list_find_value(visited_ids, i);
//        if (!instance_exists(node_id)) {
//            ds_list_destroy(visited_ids);
//            ds_list_destroy(addrs_traversed);
//            return false;
//        }
//        if (!variable_instance_exists(node_id, "energized") || node_id.energized != true) {
//            ds_list_destroy(visited_ids);
//            ds_list_destroy(addrs_traversed);
//            return false;
//        }
//    }

//    // passou todas checagens
//    ds_list_destroy(visited_ids);
//    ds_list_destroy(addrs_traversed);
//    return true;
//}






/// check_sequence(head_id, target_list, use_nodes = false) -> true/false
function check_sequence(head_id, target_list, use_nodes = false) {
    // validações básicas
    if (!instance_exists(head_id)) return false;
    if (!ds_exists(target_list, ds_type_list)) return false;

    // traversal estático (seguir target_inst) e detectar ciclo
    var visited_ids = ds_list_create();
    var addrs_traversed = ds_list_create();
    var cur = head_id;
    var iteration_limit = 10000;
    var iter = 0;
    while (cur != noone && instance_exists(cur) && iter < iteration_limit) {
        // detecta ciclo (mesma instância repetida)
        if (ds_list_find_index(visited_ids, cur) != -1) {
            ds_list_destroy(visited_ids);
            ds_list_destroy(addrs_traversed);
            return false;
        }
        ds_list_add(visited_ids, cur);

        // guarda address (se existir)
        var addr_val = "";
        if (variable_instance_exists(cur, "address")) {
            addr_val = cur.address;
        }
        ds_list_add(addrs_traversed, addr_val);

        // avança
        var next = noone;
        if (variable_instance_exists(cur, "target_inst")) next = cur.target_inst;
        cur = next;
        iter += 1;
    }
    if (iter >= iteration_limit) {
        ds_list_destroy(visited_ids);
        ds_list_destroy(addrs_traversed);
        return false;
    }

    // comparar tamanhos (mesmo para nodes)
    if (ds_list_size(addrs_traversed) != ds_list_size(target_list)) {
        ds_list_destroy(visited_ids);
        ds_list_destroy(addrs_traversed);
        return false;
    }

    // para cada elemento: comparar endereço, energized, e (se use_nodes) payload
    var size = ds_list_size(addrs_traversed);
    for (var i = 0; i < size; ++i) {
        var want_entry = ds_list_find_value(target_list, i);

        // Extrair endereço esperado e, se aplicável, payload esperado
        var want_addr = noone;
        var want_payload = noone;
        var want_has_payload = false;

        if (use_nodes && ds_exists(want_entry, ds_type_map)) {
            // caso avançado: elemento é um map { "address": ..., "payload": ... }
            if (ds_map_exists(want_entry, "address")) want_addr = ds_map_find_value(want_entry, "address");
            if (ds_map_exists(want_entry, "payload")) {
                want_payload = ds_map_find_value(want_entry, "payload");
                want_has_payload = true;
            }
        } else {
            // elemento simples (apenas endereço)
            want_addr = want_entry;
        }

        var got_addr = ds_list_find_value(addrs_traversed, i);

        // comparação robusta do endereço
        var equal_addr = false;
        if (is_string(want_addr) || is_string(got_addr)) {
            equal_addr = (string(want_addr) == string(got_addr));
        } else {
            equal_addr = (real(want_addr) == real(got_addr));
        }
        if (!equal_addr) {
            ds_list_destroy(visited_ids);
            ds_list_destroy(addrs_traversed);
            return false;
        }

        // checar energized do pointer
        var node_id = ds_list_find_value(visited_ids, i);
        if (!instance_exists(node_id)) {
            ds_list_destroy(visited_ids);
            ds_list_destroy(addrs_traversed);
            return false;
        }
        if (!variable_instance_exists(node_id, "energized") || node_id.energized != true) {
            ds_list_destroy(visited_ids);
            ds_list_destroy(addrs_traversed);
            return false;
        }

        // se estamos no modo nodes e existe payload esperado, checar payload do slot
        if (use_nodes && want_has_payload) {
            // localizar slot associado ao node_id
            var slot = noone;

            // preferimos procurar por node_label no pointer, se existir
            if (variable_instance_exists(node_id, "node_label") && string(node_id.node_label) != "") {
                // se você implementou find_slot_by_label, usamos; senão fallback
                if (!is_undefined(find_slot_by_label)) {
                    slot = find_slot_by_label(node_id.node_label);
                } else {
                    // fallback: procurar manualmente por node_label entre todos os slots
                    var ns = instance_number(obj_data_slot);
                    for (var jj = 0; jj < ns; ++jj) {
                        var s = instance_find(obj_data_slot, jj);
                        if (!instance_exists(s)) continue;
                        if (variable_instance_exists(s, "node_label") && string(s.node_label) == string(node_id.node_label)) {
                            slot = s;
                            break;
                        }
                    }
                }
            }

            // se não encontrou por node_label, tentar por address comparando slot.address
            if (slot == noone) {
                var ns2 = instance_number(obj_data_slot);
                for (var jj2 = 0; jj2 < ns2; ++jj2) {
                    var s2 = instance_find(obj_data_slot, jj2);
                    if (!instance_exists(s2)) continue;
                    if (variable_instance_exists(s2, "address")) {
                        if (is_string(got_addr) || is_string(s2.address)) {
                            if (string(s2.address) == string(got_addr)) { slot = s2; break; }
                        } else {
                            if (real(s2.address) == real(got_addr)) { slot = s2; break; }
                        }
                    }
                }
            }

            // obter payload atual do slot
            var payload_actual = noone;
            if (slot != noone && instance_exists(slot)) {
                if (!is_undefined(get_slot_payload)) {
                    payload_actual = get_slot_payload(slot);
                } else {
                    // fallback: prefer payload, senão datacore_inst.payload
                    if (variable_instance_exists(slot, "payload") && slot.payload != null) {
                        payload_actual = slot.payload;
                    } else if (variable_instance_exists(slot, "datacore_inst") && slot.datacore_inst != noone && instance_exists(slot.datacore_inst)) {
                        if (variable_instance_exists(slot.datacore_inst, "payload")) payload_actual = slot.datacore_inst.payload;
                    }
                }
            } else {
                payload_actual = noone;
            }

            // comparar payload (strings)
            if (payload_actual == noone) {
                ds_list_destroy(visited_ids);
                ds_list_destroy(addrs_traversed);
                return false;
            }
            if (string(payload_actual) != string(want_payload)) {
                ds_list_destroy(visited_ids);
                ds_list_destroy(addrs_traversed);
                return false;
            }
        } // end payload check

    } // end for

    // passou todas checagens
    ds_list_destroy(visited_ids);
    ds_list_destroy(addrs_traversed);
    return true;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// check_sequence_array(target_list) -> true/false
function check_sequence_array(target_list) {
    if (!ds_exists(target_list, ds_type_list)) return false;
    var size = ds_list_size(target_list);
    for (var i = 0; i < size; ++i) {
        var want_entry = ds_list_find_value(target_list, i);

        // deve ser um map com array_id e index
        if (!ds_exists(want_entry, ds_type_map) || !ds_map_exists(want_entry, "array_id") || !ds_map_exists(want_entry, "index")) {
            return false; // formato inválido para modo array
        }

        var aid = ds_map_find_value(want_entry, "array_id");
        var idx = ds_map_find_value(want_entry, "index");

        var elem = find_array_element(aid, idx);
        if (elem == noone) return false;

        // checar se ocupado (se exigido)
        var req_occ = false;
        if (ds_map_exists(want_entry, "require_occupied")) req_occ = ds_map_find_value(want_entry, "require_occupied");
        if (req_occ) {
            if (!variable_instance_exists(elem, "datacore_inst") || elem.datacore_inst == noone) return false;
        }

        // checar payload se especificado
        if (ds_map_exists(want_entry, "payload")) {
            var want_payload = ds_map_find_value(want_entry, "payload");
            // pegar payload atual do elemento (adaptar conforme sua implementação)
            var actual_payload = "";
            if (variable_instance_exists(elem, "payload") && elem.payload != "null") actual_payload = string(elem.payload);
            //else if (variable_instance_exists(elem, "datacore_inst") && elem.datacore_inst != noone && instance_exists(elem.datacore_inst)) {
            //    if (variable_instance_exists(elem.datacore_inst, "payload")) actual_payload = string(elem.datacore_inst.payload);
            //}
            if (string(actual_payload) != string(want_payload)) return false;
        }

        // opcional: checar energized se pedido
        //if (ds_map_exists(want_entry, "require_energized") && ds_map_find_value(want_entry, "require_energized")) {
        //    if (!variable_instance_exists(elem, "energized") || elem.energized != true) return false;
        //}
    }
    return true;
}






function signal_target(target_key) {
    if (is_undefined(target_key)) return;
    var n = instance_number(obj_indicator);
    for (var i = 0; i < n; ++i) {
        var inst = instance_find(obj_indicator, i);
        if (!instance_exists(inst)) continue;
        if (!variable_instance_exists(inst, "target_key")) continue;
        if (string(inst.target_key) == string(target_key)) {
            // garante que exista flash_frames definido no indicador (fallback)
            if (!variable_instance_exists(inst, "flash_frames")) inst.flash_frames = max(1, round(0.12 * 60));
            inst.flash_timer = inst.flash_frames;
        }
    }
}