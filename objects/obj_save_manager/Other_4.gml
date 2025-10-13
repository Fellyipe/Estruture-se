///// obj_save_manager - Room Start
//var rn = room_get_name(room);

//// 1) criar snapshot inicial se não existir
//if (!variable_struct_exists(save_state, "rooms_initial")) save_state.rooms_initial = {};
//if (!variable_struct_exists(save_state.rooms_initial, rn)) {
//    // cria initial snapshot (não altera disco)
//    var initial = save_room_state_simple(rn);
//    save_state.rooms_initial[$ rn] = initial;
//    show_debug_message("Initial snapshot criado para: " + rn);
//}

//// 2) se houver checkpoint para a sala, aplica; senão aplica initial (opcional)
//if (variable_struct_exists(save_state, "rooms_checkpoint") && variable_struct_exists(save_state.rooms_checkpoint, rn)) {
//    show_debug_message("Aplicando checkpoint para: " + rn);
//    apply_room_state_simple(rn, save_state.rooms_checkpoint);
//} else {
//    // opcional aplicar initial — se quiser começar exatamente como editor sempre,
//    // comente a linha abaixo. Para aplicar o initial ao voltar, descomente:
//    // apply_room_state_simple(rn, save_state.rooms_initial);
//}


/// obj_save_manager - Room Start (versão robusta)

var rn = room_get_name(room);

// --- 0) garantir que save_state existe e é struct ---
//if (!variable_global_exists("save_state") || !is_struct(save_state)) {
//    // se não existe, cria uma estrutura mínima (normalmente o manager já inicializou isso no Create)
//    save_state = {
//        meta: { version: global.save_version, last_save_slot: -1, timestamp: "" },
//        player: {},
//        rooms: {},
//        rooms_initial: {},
//        rooms_checkpoint: {},
//        dirty_rooms: {}
//    };
//}
var ss = save_state; // alias curto

// --- 1) Caso: carregamento por slot (pending_save_state) vindo de load_slot() ---
// se o menu chamou load_slot e definiu global.pending_save_state, aplicamos esse estado
if (variable_global_exists("pending_save_state") && global.pending_save_state != undefined) {
    var loaded = global.pending_save_state;
    // validação mínima
    if (is_struct(loaded) && variable_struct_exists(loaded, "meta")) {
        // substitui o save_state atual pela struct carregada (sempre em memória)
        save_state = loaded;
        ss = save_state; // atualizar alias
        show_debug_message("obj_save_manager: pending save_state aplicado (slot load).");

        // aplicar room específica do loaded: se existir rooms e room entry, aplicar
        var target_room_name = room_get_name(room);
        // se o save tem rooms e a room atual está presente, aplica
        if (variable_struct_exists(ss, "rooms") && variable_struct_exists(ss.rooms, target_room_name)) {
            apply_room_state_simple(target_room_name, ss.rooms);
        } else if (variable_struct_exists(ss, "rooms_checkpoint") && variable_struct_exists(ss.rooms_checkpoint, target_room_name)) {
            apply_room_state_simple(target_room_name, ss.rooms_checkpoint);
        } else if (variable_struct_exists(ss, "rooms_initial") && variable_struct_exists(ss.rooms_initial, target_room_name)) {
            apply_room_state_simple(target_room_name, ss.rooms_initial);
        } else {
            show_debug_message("obj_save_manager: pending save não continha dados para a room '" + target_room_name + "'.");
        }

        // posicionar player segundo o loaded.player (se presente)
        if (variable_struct_exists(ss, "player")) {
            var prow = ss.player;
            if (variable_struct_exists(prow, "room_name") && prow.room_name == room_get_name(room)) {
                if (instance_exists(obj_player)) {
                    with (obj_player) {
                        if (variable_struct_exists(prow, "x")) x = prow.x;
                        if (variable_struct_exists(prow, "y")) y = prow.y;
                    }
                } else {
                    // guardar spawn para o Create do player
                    global.player_spawn_x = prow.x;
                    global.player_spawn_y = prow.y;
                }
            }
        }

        // recompute energy e limpeza do pending
        if (!is_undefined(recompute_energy)) recompute_energy();
    } else {
        show_debug_message("obj_save_manager: pending_save_state inválido ou corrompido.");
    }

    // limpar pending (executado mesmo se inválido, para não re-tentar eternamente)
    global.pending_save_state = undefined;
    global.pending_load = noone;
    return; // já aplicamos o load — sair do Room Start
}

// --- 2) Normal flow: não veio load do disco ---
// garantir sub-structs
if (!variable_struct_exists(ss, "rooms_initial") || !is_struct(ss.rooms_initial)) ss.rooms_initial = {};
if (!variable_struct_exists(ss, "rooms_checkpoint") || !is_struct(ss.rooms_checkpoint)) ss.rooms_checkpoint = {};
if (!variable_struct_exists(ss, "rooms") || !is_struct(ss.rooms)) ss.rooms = {};

// --- 3) Criar snapshot inicial (uma vez) se não existir ---
// Fazemos isso antes de aplicar saves para garantir que haja algo para reset
if (!variable_struct_exists(ss.rooms_initial, rn)) {
    // cria snapshot inicial da sala (não grava em disco)
    var initial = save_room_state_simple(rn);
    ss.rooms_initial[$ rn] = initial;
    show_debug_message("obj_save_manager: Initial snapshot criado para: " + rn);
}

// --- 4) Ordem de aplicação quando não houve load por arquivo ---
// Preferência de restauração:
// 1) se o jogador salvou manualmente (ss.rooms) -> aplica este (manual save)
// 2) else se existir checkpoint (ss.rooms_checkpoint) -> aplica checkpoint
// 3) else aplicar initial (opcional) -> decide se quer aplicar initial por padrão
var applied = false;

// 4.1 aplicar checkpoint (se não tiver manual save)
if (variable_struct_exists(ss, "rooms_checkpoint") && variable_struct_exists(ss.rooms_checkpoint, rn)) {
    show_debug_message("obj_save_manager: Aplicando checkpoint em memória para: " + rn);
    apply_room_state_simple(rn, ss.rooms_checkpoint);
    applied = true;
}
// 4.2 aplicar manual save (se existir)
else if (variable_struct_exists(ss, "rooms") && variable_struct_exists(ss.rooms, rn)) {
    show_debug_message("obj_save_manager: Aplicando manual save em memória para: " + rn);
    apply_room_state_simple(rn, ss.rooms);
    applied = true;
}
// 4.3 aplicar initial - escolha opcional: aplicar para garantir estado consistente
if (!applied) {
    // se quiser que voltar à sala mantenha exatamente o layout do editor, deixe aplicar initial
    var APPLY_INITIAL_ON_RETURN = false; // <-- Mude para false se preferir não reaplicar initial automaticamente
    if (APPLY_INITIAL_ON_RETURN) {
        show_debug_message("obj_save_manager: Aplicando initial para: " + rn);
        apply_room_state_simple(rn, ss.rooms_initial);
    }
}

// --- 5) aplicar player spawn se houver um player state em memória (por exemplo, se você voltou da mesma sessão) ---
if (variable_struct_exists(ss, "player")) {
    var prow2 = ss.player;
    if (variable_struct_exists(prow2, "room_name") && prow2.room_name == rn) {
        if (instance_exists(obj_player)) {
            with (obj_player) {
                if (variable_struct_exists(prow2, "x")) x = prow2.x;
                if (variable_struct_exists(prow2, "y")) y = prow2.y;
            }
        } else {
            global.player_spawn_x = (variable_struct_exists(prow2, "x") ? prow2.x : global.player_spawn_x);
            global.player_spawn_y = (variable_struct_exists(prow2, "y") ? prow2.y : global.player_spawn_y);
        }
    }
}

// --- 6) recompute energy no final ---
if (!is_undefined(recompute_energy)) recompute_energy();
	