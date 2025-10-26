// Re-apply for room changes
var cam = view_camera[0];
camera_set_view_pos(cam, 0, 0);
camera_set_view_size(cam, global.base_w, global.base_h);

surface_resize(application_surface, global.base_w, global.base_h);
if (!surface_exists(application_surface)) {
    surface_resize(application_surface, global.base_w, global.base_h);
}

view_wport[0] = global.base_w;
view_hport[0] = global.base_h;
view_xport[0] = 0;
view_yport[0] = 0;

display_set_gui_size(global.base_w, global.base_h);
