// obj_concept_notify - Step

// pulso
pulse_timer += 1;
var pulse = 1 + 0.03 * sin(pulse_timer * pulse_speed);
var pulse_alpha = 0.85 + 0.15 * sin(pulse_timer * pulse_speed);

// Condições para remover/consumir a notificação:
// 1) jogador abriu o tablet na mesma sala
var tablet_open = false;
if (instance_exists(obj_tablet)) {
    // assumimos obj_tablet tem campo tablet_open
    var t = instance_find(obj_tablet, 0);
    if (t != noone && variable_instance_exists(t, "tablet_open") && t.tablet_open) tablet_open = true;
}
if (tablet_open && spawn_room == room_get_name(room)) {
    // jogador abriu o tablet na mesma sala -> marca como visto e destrói
    instance_destroy();
    exit;
}

// 2) jogador saiu da sala (room change): se room atual diferente do spawn_room
if (spawn_room != room_get_name(room)) {
    instance_destroy();
    exit;
}

// 3) se existe um pending_load (ou outro flag que indique load/save) vamos considerar como visto
if (variable_global_exists("pending_load") && global.pending_load != noone) {
    instance_destroy();
    exit;
}

// 4) opcional: se você quiser que salvar também consuma notification, verifique global.pending_save
if (variable_global_exists("pending_save") && global.pending_save != noone) {
    instance_destroy();
    exit;
}

// opcional: se tablet já estiver aberto e é outra room, destrói também (defensive)
if (tablet_open && spawn_room != room_get_name(room)) {
    instance_destroy();
    exit;
}

// atualiza alpha / scale para draw
image_alpha = pulse_alpha; // O alpha agora recebe o valor do pulso
image_xscale = 1;          // A escala fica constante
image_yscale = 1;
