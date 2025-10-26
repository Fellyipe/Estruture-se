/// scr_display_system
/// Complete display scaling system for pixel-perfect fullscreen

/// @function display_initialize()
/// @description Sets up fullscreen with integer scaling. Call once at game start.
function display_initialize() {
    
    // Step 1: Get the actual monitor resolution
    var monitor_width = display_get_width();
    var monitor_height = display_get_height();
    
    // Step 2: Calculate the maximum integer scale factor that fits
    var scale_x = floor(monitor_width / global.game_width);
    var scale_y = floor(monitor_height / global.game_height);
    
    // Use the smaller scale to ensure both dimensions fit
    global.display_scale = min(scale_x, scale_y);
    
    // Ensure minimum scale of 1
    if (global.display_scale < 1) {
        global.display_scale = 1;
    }
    
    // Step 3: Calculate the actual scaled dimensions
    var scaled_width = global.game_width * global.display_scale;
    var scaled_height = global.game_height * global.display_scale;
    
    // Step 4: Calculate centering offsets (for black bars)
    var offset_x = floor((monitor_width - scaled_width) / 2);
    var offset_y = floor((monitor_height - scaled_height) / 2);
    
    // Step 5: Set the window size to monitor size BEFORE going fullscreen
    // This prevents GameMaker from using a cached window size
    window_set_size(monitor_width, monitor_height);
    
    // Small delay to let the window resize settle
    // (This is optional but can help on some systems)
    
    // Step 6: Enable true fullscreen
	window_enable_borderless_fullscreen(true);
    window_set_fullscreen(true);
    
    // Step 7: Configure the application surface
    // Resize it to match our scaled dimensions
    surface_resize(application_surface, scaled_width, scaled_height);
    
    // Step 8: Configure the camera and viewport for view[0]
    // The camera views the game at native resolution
    var cam = view_camera[0];
    camera_set_view_size(cam, global.game_width, global.game_height);
    
    // The viewport displays the camera's view at scaled resolution
    view_wport[0] = scaled_width;
    view_hport[0] = scaled_height;
    
    // Position the viewport with centering offsets
    view_xport[0] = offset_x;
    view_yport[0] = offset_y;
    
    // Step 9: Configure GUI layer to match native resolution
    // This ensures GUI elements are drawn at the correct scale
    display_set_gui_size(global.game_width, global.game_height);
    
    // Debug output (remove in production)
    show_debug_message("=== Display Initialization ===");
    show_debug_message("Monitor: " + string(monitor_width) + "x" + string(monitor_height));
    show_debug_message("Scale Factor: " + string(global.display_scale) + "x");
    show_debug_message("Scaled Size: " + string(scaled_width) + "x" + string(scaled_height));
    show_debug_message("Offsets: X=" + string(offset_x) + " Y=" + string(offset_y));
    show_debug_message("==============================");
}

/// @function display_apply_scaling()
/// @description Reapplies scaling settings. Call in Room Start event.
function display_apply_scaling() {
    
    // Get the monitor dimensions
    var monitor_width = display_get_width();
    var monitor_height = display_get_height();
    
    // Calculate scaled dimensions using stored scale factor
    var scaled_width = global.game_width * global.display_scale;
    var scaled_height = global.game_height * global.display_scale;
    
    // Calculate centering offsets
    var offset_x = floor((monitor_width - scaled_width) / 2);
    var offset_y = floor((monitor_height - scaled_height) / 2);
    
    // Ensure fullscreen is still active
    if (!window_get_fullscreen()) {
		window_enable_borderless_fullscreen(true);
        window_set_fullscreen(true);
    }
    
    // Reapply surface size
    surface_resize(application_surface, scaled_width, scaled_height);
    
    // Reapply camera and viewport settings
    var cam = view_camera[0];
    camera_set_view_size(cam, global.game_width, global.game_height);
    
    view_wport[0] = scaled_width;
    view_hport[0] = scaled_height;
    view_xport[0] = offset_x;
    view_yport[0] = offset_y;
    
    // Reapply GUI scaling
    display_set_gui_size(global.game_width, global.game_height);
}

/// @function display_toggle_fullscreen()
/// @description Toggles between fullscreen and windowed mode
function display_toggle_fullscreen() {
    
    if (window_get_fullscreen()) {
        // Switch to windowed mode
        window_set_fullscreen(false);
        
        // Set window to 2x native resolution for windowed mode
        var window_scale = 2;
        window_set_size(global.game_width * window_scale, global.game_height * window_scale);
        
        // Reset surface to native resolution
        surface_resize(application_surface, global.game_width, global.game_height);
        
        // Reset viewport
        view_wport[0] = global.game_width;
        view_hport[0] = global.game_height;
        view_xport[0] = 0;
        view_yport[0] = 0;
        
    } else {
        // Switch back to fullscreen
        display_initialize();
    }
}
