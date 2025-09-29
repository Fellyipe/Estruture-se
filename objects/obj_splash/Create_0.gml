state       = "fade_in";  
frame_count = 0;        // contador genérico
alpha       = 0;        // opacidade inicial

var spr_w = sprite_get_width(splash_sprite);
var spr_h = sprite_get_height(splash_sprite);
// espaço útil: 60% da largura ou altura da room
var max_w = room_width  * 0.6;
var max_h = room_height * 0.6;
var scale_w = max_w / spr_w;
var scale_h = max_h / spr_h;
sprite_scale = min(scale_w, scale_h);

loading_groups = [BGM, SFX];
current_load = 0;

audio_group_load(loading_groups[current_load]);

loading_complete = false;