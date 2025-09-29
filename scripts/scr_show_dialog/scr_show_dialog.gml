/*/// scr_show_dialog(text, portrait_sprite, subimg, speaker_name, char_speed, on_close)
/// portrait_sprite pode ser noone se não quiser portrait
/// on_close deve ser uma função anônima (function() { ... }) ou undefined

var _text         = argument0;
var _portrait     = argument_count > 1 ? argument1 : noone;
var _subimg       = argument_count > 2 ? argument2 : 0;
var _speaker      = argument_count > 3 ? argument3 : "";
var _char_speed   = argument_count > 4 ? argument4 : 45;
var _on_close     = argument_count > 5 ? argument5 : undefined;

// evita múltiplas caixas: se já existir, ignora (ou você pode destruir a anterior antes)
if (instance_exists(obj_dialogue_box)) {
    // você pode escolher substituir a antiga chamando instance_destroy() aqui.
    // instance_destroy(instance_nearest(x, y, obj_dialogue));
    return -1;
}

// cria a instância na layer GUI ou Overlay
//var o = instance_create_layer(0, 0, "GUI", obj_dialogue_box);
var o = instance_create_depth(0, 0, 9999, obj_dialogue_box);

// inicializa as variáveis (Create já rodou, então sobrescrevemos)
o.text = string(_text);
o.portrait_sprite = _portrait;
o.portrait_subimg = _subimg;
o.speaker_name = string(_speaker);
o.char_speed = _char_speed;
o.on_close = _on_close;

// recalcula delay frames com a nova speed
o.char_delay_frames = max(1, round(room_speed / o.char_speed));
o.typed_chars = 0;
o.typing = true;
o.char_frame_accum = 0;
o.blink_timer = 0;

return o; // retorna a instância criada
*/