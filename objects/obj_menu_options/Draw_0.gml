draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_menu);

var start_y = room_height * 2/7;
var spacing = 50;
var cx = room_width / 2;
var cx_options = room_width/2 + 180;

// Desenha o painel de fundo
draw_set_color(c_black);
var panelx1 = 1/7 * room_width;
var panelx2 = room_width - panelx1;
var panely1 = 1/7 * room_height;
var panely2 = room_height - panely1;

draw_rectangle(panelx1, panely1, panelx2, panely2, false);

// Título
draw_set_color(c_white);
draw_text(room_width/2, 2/11 * room_height, menu_label);

for (var i = 0; i < array_length(menu_items); i++) {
    var item = menu_items[i];
	var text = item.text;
	var text_value = "";
    var y_text = start_y + i * spacing;
    
    if (i == selected_index) {
        draw_set_color(c_yellow);
        draw_text(cx, y_text, "> " + text);
    } else {
        draw_set_color(c_white);
        draw_text(cx, y_text, text);
    }
	
	switch(item.var_name) {
        case "volume_music":
            text_value = string(round(audio_group_get_gain(BGM) * 100)) + "%";
            break;
        case "volume_sfx":
            text_value = string(round(audio_group_get_gain(SFX) * 100)) + "%";
            break;
        case "resolution":
            text_value = item.options[resolution_index];
            break;
        case "fullscreen":
            text_value = window_get_fullscreen() ? "On" : "Off";
            break;
        // action não precisa de valor
    }
    if (text_value != "") draw_text(cx_options, y_text, text_value);
}

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(room_width/2, room_height-20, "v1.0");
