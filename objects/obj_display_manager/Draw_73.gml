/// Draw End - obj_display_manager
// reset target to backbuffer
if (surface_exists(render_surface)) surface_reset_target();

// read current window size (may change during runtime)
var sw = display_get_width();
var sh = display_get_height();

// recompute valid integer scales (only when window size changes - optimization)
if (sw != _last_sw || sh != _last_sh) {
    ds_list_clear(valid_scales);
    var maxScaleW = floor(sw / virtual_w);
    var maxScaleH = floor(sh / virtual_h);
    var maxScale = max(1, min(maxScaleW, maxScaleH));
    for (var s = 1; s <= maxScale; s++) ds_list_add(valid_scales, s);
    // default to largest that fits
    if (ds_list_size(valid_scales) > 0) zoom = ds_list_find_value(valid_scales, ds_list_size(valid_scales)-1);
    _last_sw = sw; _last_sh = sh;
}

// compute scaled dims and offsets
var scaled_w = virtual_w * zoom;
var scaled_h = virtual_h * zoom;
offset_x = floor((sw - scaled_w) / 2);
offset_y = floor((sh - scaled_h) / 2);

// draw letterbox/pillarbox
draw_set_color(letterbox_color);
if (offset_y > 0) {
    draw_rectangle(0, 0, sw, offset_y, false); // top
    draw_rectangle(0, offset_y + scaled_h, sw, sh, false); // bottom
}
if (offset_x > 0) {
    draw_rectangle(0, offset_y, offset_x, offset_y + scaled_h, false); // left
    draw_rectangle(offset_x + scaled_w, offset_y, sw, offset_y + scaled_h, false); // right
}
draw_set_color(c_white);

// draw the render surface scaled to window
if (surface_exists(render_surface)) {
    // nearest filtering preserved
    draw_surface_ext(render_surface, offset_x, offset_y, zoom, zoom, 0, c_white, 1);
}
