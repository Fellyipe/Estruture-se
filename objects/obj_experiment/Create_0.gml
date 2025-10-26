/// CONFIG (ajuste no editor se preferir)
array_id = "array_1";      // id do seu array elements colocados em room
head_pointer = find_pointer_by_address("0x1111");          // opcional: você pode setar no editor a instância head,
                              // se não setado, o controller procura um obj_pointer com is_head==true
auto_start = true;

// tempos (em segundos) — ajuste visual
node_flash_time = 1.5;   // cada nó da lista fica destacado (s)
array_flash_time = 1.5;  // pulso do array (s)
inter_gap = 0.04;         // gap entre flashes da lista (s)
post_round_pause = 1.8;   // pausa após list terminar (s)

// estado interno (não editar no editor)
state = "idle";           // "idle", "running_list", "post_pause"
reading = false;
round_timer_frames = 0;
current_nodes = [];
current_k = -1;
current_list_index = 0;

// converte tempo->frames
_fps = 60;
node_flash_frames = max(1, round(node_flash_time * _fps));
array_flash_frames = max(1, round(array_flash_time * _fps));
inter_gap_frames = max(0, round(inter_gap * _fps));
post_pause_frames = max(1, round(post_round_pause * _fps));

// escolha tamanho N: detecta automaticamente array size (conta elementos com same array_id)
array_size = 0;
var nn = instance_number(obj_array_element);
for (var i = 0; i < nn; ++i) {
    var inst = instance_find(obj_array_element, i);
    if (!instance_exists(inst)) continue;
    if (variable_instance_exists(inst, "array_id") && string(inst.array_id) == string(array_id)) array_size += 1;
}
// fallback: se não encontrar elementos, tente contar nodes from head (se houver)
if (array_size == 0) {
    // tenta contar por ponteiros ligados a head_pointer se for uma lista espelhada
    array_size = 5; // default para evitar divisão por zero; ajuste pelo editor se quiser
}

// optional: try to auto-find head pointer if not set
if (!(instance_exists(head_pointer))) {
    var pn = instance_number(obj_pointer);
    for (var j = 0; j < pn; ++j) {
        var p = instance_find(obj_pointer, j);
        if (!instance_exists(p)) continue;
        if (variable_instance_exists(p, "is_head") && p.is_head) {
            head_pointer = p;
            break;
        }
    }
}

// start initial delay
if (auto_start) {
    // small delay before first round
    round_timer_frames = max(1, round(0.5 * _fps));
} else {
    round_timer_frames = -1;
}


list_wait_frames = 0;

global.indice_sorteado = 0; // -1 ou "Nenhum" para indicar que nada foi sorteado ainda

