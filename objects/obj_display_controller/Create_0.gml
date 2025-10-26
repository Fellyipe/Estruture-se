persistent = true;

global.base_w = 640;
global.base_h = 360;

// Monitor dimensions
var disp_w = display_get_width();
var disp_h = display_get_height();

// Integer scale calculation
var scale_x = floor(disp_w / global.base_w);
var scale_y = floor(disp_h / global.base_h);
global.scale = max(1, min(scale_x, scale_y));

global.scaled_w = global.base_w * global.scale;
global.scaled_h = global.base_h * global.scale;
global.bar_x = floor((disp_w - global.scaled_w) / 2);
global.bar_y = floor((disp_h - global.scaled_h) / 2);

// Essential resets BEFORE fullscreen
var cam = view_camera[0];
camera_set_view_pos(cam, 0, 0);  // Fixes zoomed corner
camera_set_view_size(cam, global.base_w, global.base_h);

view_enabled = true;
view_visible[0] = true;
view_wport[0] = global.base_w;  // Viewport at base for internal logic
view_hport[0] = global.base_h;
view_xport[0] = 0;
view_yport[0] = 0;

// Now activate fullscreen and override defaults
window_set_fullscreen(true);
application_surface_draw_enable(false);  // Critical: Manual control
surface_resize(application_surface, global.base_w, global.base_h);  // Base res only

display_set_gui_size(global.base_w, global.base_h);  // GUI at base

// Safeguard: Force surface recreation if needed
if (!surface_exists(application_surface)) {
    surface_resize(application_surface, global.base_w, global.base_h);
}

show_debug_message("Setup: Scale " + string(global.scale) + "x | Bars " + string(global.bar_x) + "," + string(global.bar_y) + " | Surface " + string(surface_get_width(application_surface)) + "x" + string(surface_get_height(application_surface)));
