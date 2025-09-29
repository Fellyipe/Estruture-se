global.pause_count = max(0, global.pause_count - 1);
if (global.pause_count == 0) {
    global.is_paused = false;
    for (var i=0; i < array_length(pause_targets); i++) {
        var t = pause_targets[i];
        if (t != object_index) instance_activate_object(t);
    }
    audio_group_set_gain(BGM, audio_group_get_gain(BGM) * 2, 1500);
}

if (surface_exists(surf_pause)) {
    surface_free(surf_pause);
    surf_pause = -1;
}