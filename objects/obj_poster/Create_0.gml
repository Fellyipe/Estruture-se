/// @description Configurações do Poster Interativo

is_open = false;
input_cooldown = 0;
input_cooldown_max = 8;

prompt_distance = 48;
allow_close_with_esc = true;

addresses_list = [];

gui_sprite = spr_empty_poster;
scale = 0.82;

// --- Controle de Animação e Estado ---
_prev_paused = false;
animation_progress = 0;
animation_speed = 0.1;