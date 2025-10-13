/// Step - obj_display_manager
// toggle scales with Z (cycle through valid_scales)
if (keyboard_check_pressed(ord("Z"))) {
    var n = ds_list_size(valid_scales);
    if (n > 0) {
        // find current index
        var idx = -1;
        for (var i = 0; i < n; i++) {
            if (ds_list_find_value(valid_scales, i) == zoom) { idx = i; break; }
        }
        idx = (idx + 1) mod n;
        zoom = ds_list_find_value(valid_scales, idx);
    }
}
