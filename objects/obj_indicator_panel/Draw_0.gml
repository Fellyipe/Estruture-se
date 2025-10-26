if (global.indice_sorteado < -1 || global.indice_sorteado > 4) {
	global.indice_sorteado = -1;
}
draw_sprite(spr_indicator_panel, global.indice_sorteado + 1, x, y);


