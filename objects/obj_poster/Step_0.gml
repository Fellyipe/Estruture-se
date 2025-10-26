/// Step

// cooldown
if (input_cooldown > 0) input_cooldown -= 1;

// proximidade do player
var p = instance_nearest(x, y, obj_player);
var can_interact = (p != noone) && point_distance(x, y, p.x, p.y) <= prompt_distance;

// abrir overlay
if (!is_open && can_interact && keyboard_check_pressed(ord("E")) && input_cooldown == 0) {
    // não abrir se já existe outro overlay aberto
    if (global.ui_blocked) {
        // opcional: feedback breve
        // scr_show_popup("Outro documento já está aberto.", 1.2);
    } else {
        is_open = true;
        global.ui_blocked = true;
        // guardar estado anterior de pausa e pausar o jogo
        _prev_paused = (variable_global_exists("is_paused") ? global.is_paused : false);
        global.is_paused = true;
        input_cooldown = input_cooldown_max;
    }
}

var target = is_open ? 1 : 0;

animation_progress = lerp(animation_progress, target, animation_speed);

if (animation_progress < 0.95) {
    exit;
}

// fechar overlay com E ou ESC
if (is_open) {
    if ((keyboard_check_pressed(ord("E")) || (allow_close_with_esc && keyboard_check_pressed(vk_escape))) && input_cooldown == 0) {
        is_open = false;
        global.ui_blocked = false;
        global.is_paused = _prev_paused;
        input_cooldown = input_cooldown_max;
		animation_progress = 0;
    }
}

// caso o jogador saia da sala / overlay sendo destruído, garantir restauração (cuidado)
