/*function scr_show_dialog(text, portrait_sprite, portrait_subimg, options) {
	/// portrait_sprite: sprite index ou noone
	/// portrait_subimg: subimage index (0 por padrão)
	/// options: struct opcional com campos:
	//   speed (chars/sec) - default 60
	//   wrap_width (px) - largura máxima do texto dentro do box (override automático conforme portrait)
	//   font (font id) - fonte a usar (opcional)
	//   key_advance (virtual key) - tecla para avançar: default vk_enter
	//   sound_each (sound id) - opcional, som curto ao digitar (pode ser noone)
	//   on_finish (function/script) - opcional callback quando fechar
	//   panel_alpha (0..255) - alpha do painel, default 200
	//   panel_padding (px) - padding interno, default 14

	// evita criar múltiplas caixas simultâneas (conforme solicitado)
	if (instance_exists(obj_dialog_box)) {
	    // substitui comportamento: opcionalmente podemos destruir a anterior e abrir nova
	    // aqui, ignoramos novas chamadas para manter uma caixa por vez
	    return noone;
	}

	// cria instancia na layer "Overlay" ou "GUI" — ajuste o nome se não existir
	var o = instance_create_layer(0, 0, "Overlay", obj_dialog_box);

	// define campos
	with (o) {
	    dialog_text = string(text);
	    portrait_sprite = is_undefined(portrait_sprite) ? noone : portrait_sprite;
	    portrait_subimg = si_max(0, real(portrait_subimg)); // garante inteiro
	    // opções padrão
	    speed_chars_per_sec = (is_struct(options) && variable_struct_exists(options,"speed")) ? options.speed : 60;
	    font_to_use = (is_struct(options) && variable_struct_exists(options,"font")) ? options.font : noone;
	    key_advance = (is_struct(options) && variable_struct_exists(options,"key_advance")) ? options.key_advance : vk_enter;
	    sound_each = (is_struct(options) && variable_struct_exists(options,"sound_each")) ? options.sound_each : noone;
	    on_finish = (is_struct(options) && variable_struct_exists(options,"on_finish")) ? options.on_finish : noone;
	    panel_alpha = (is_struct(options) && variable_struct_exists(options,"panel_alpha")) ? options.panel_alpha : 200;
	    panel_padding = (is_struct(options) && variable_struct_exists(options,"panel_padding")) ? options.panel_padding : 14;
	    wrap_width_override = (is_struct(options) && variable_struct_exists(options,"wrap_width")) ? options.wrap_width : noone;

	    // inicialização interna (o Create do objeto fará o restante também)
	}

	return o;
}*/