// desenha fundo do painel
draw_set_color(c_black);
draw_rectangle(80, 80, room_width-80, room_height-80, false);

// título
draw_set_font(fnt_menu);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(room_width/2, 96, "INVENTÁRIO");

// lista
var start_x = 120;
var start_y = 140;
var line_h = 42;
for (var i = 0; i < array_length(global.inventory); ++i) {
    var it = global.inventory[i];
    var iy = start_y + i * line_h;
    
    // ícone
    //if (it.icon != noone) {
    //    draw_sprite(it.icon, 0, start_x, iy + line_h/2);
    //}
    // nome e qty
    draw_set_halign(fa_left);
    // highlight quando selecionado
    if (i == selected) {
        draw_set_color(c_yellow);
    }
	var text_stack = it.stackable ? " x" + string(it.qty) : "";
	var text = "[" + string(it.icon) + "] " + it.item_name + " " + text_stack;
	draw_text_scribble(start_x + 40, iy, text);
	scribble("[it.icon] ");
	draw_set_color(c_white);
}
// descrição do item selecionado
if (array_length(global.inventory) > 0) {
    var sel = global.inventory[selected];
    draw_set_halign(fa_left);
    draw_text(start_x, room_height - 140, sel.description);
}
