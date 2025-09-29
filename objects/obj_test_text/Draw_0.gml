draw_set_font(fnt_menu);
var text = "Enzo é um docinho [spr_enemy]"

draw_text_scribble(32, 32, "Enzo é um docinho [spr_enemy]");

var scribble_object = scribble(text);
scribble_object.starting_format("fnt_menu", c_white);
scribble_object.draw(32, window_get_height() - 96);