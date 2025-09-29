// evita abrir múltiplos overlays do mesmo tipo
if (!instance_exists(obj_menu_pause)) {
    var o = instance_create_layer(0,0,"GUI", obj_menu_pause);
    // indica quais tipos devem ser desativados — ajuste para seu projeto
    //o.pause_targets = [obj_enemy, obj_projectile, obj_npc, obj_game_logic];
    // opcional, sobrescreve comportamento de áudio
    // o.do_audio_fade = true;
}