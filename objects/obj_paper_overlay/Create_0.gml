/// obj_paper_overlay - Create
is_open = false;
input_cooldown = 0;
input_cooldown_max = 8;

prompt_distance = 48;
allow_close_with_esc = true;
mode = "sprite";
gui_sprite = sprite_index;
scale = is_undefined(scale) ? 0.82 : scale;

// placeholder text (edite na instância)
addresses_text = ""; 

// guarda estado anterior de pausa para restaurar depois
_prev_paused = false;

// global flag para impedir múltiplos overlays abertos ao mesmo tempo
global.ui_overlay_open = noone;
