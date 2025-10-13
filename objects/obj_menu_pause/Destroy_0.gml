/// Destroy - obj_menu_pause (corrigido)
// reduzir pause stack
global.pause_count = max(0, global.pause_count - 1);

// só reativa os tipos quando não houver mais overlays pausando
if (global.pause_count == 0) {
    global.is_paused = false;
    for (var i = 0; i < array_length(pause_targets); i++) {
        var t = pause_targets[i];
        if (t != object_index) instance_activate_object(t);
    }
    // restore BGM gain to exact saved value (don't multiply)
    if (!is_undefined(saved_bgm_gain) && !is_undefined(BGM)) {
        audio_group_set_gain(BGM, saved_bgm_gain, 500);
    }
}

// free surface snapshot
if (surface_exists(surf_pause)) {
    surface_free(surf_pause);
    surf_pause = -1;
}


instance_destroy(pauser_object);