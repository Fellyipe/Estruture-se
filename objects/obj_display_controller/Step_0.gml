/// Debug - Step Event

if (keyboard_check_pressed(vk_f12)) {
    show_debug_message("=== DIAGNOSTIC ===");
    show_debug_message("Fullscreen: " + string(window_get_fullscreen()));
    show_debug_message("Window Size: " + string(window_get_width()) + "x" + string(window_get_height()));
    show_debug_message("Display Size: " + string(display_get_width()) + "x" + string(display_get_height()));
    show_debug_message("App Surface: " + string(surface_get_width(application_surface)) + "x" + string(surface_get_height(application_surface)));
    show_debug_message("Scale: " + string(global.scale));
    show_debug_message("==================");
}
