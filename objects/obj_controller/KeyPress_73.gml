if (!instance_exists(obj_invetory_ui)) {
	show_message("Dentro de i");
    var o = instance_create_layer(0,0,"GUI", obj_invetory_ui);
    // indica quais tipos devem ser desativados — ajuste para seu projeto
    //o.pause_targets = [obj_enemy, obj_projectile, obj_npc, obj_game_logic];
    // opcional, sobrescreve comportamento de áudio
    // o.do_audio_fade = true;
}