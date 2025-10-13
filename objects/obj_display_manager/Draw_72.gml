/// Draw Begin - obj_display_manager
// ensure surface exists and has correct size
if (!surface_exists(render_surface)) {
    render_surface = surface_create(virtual_w, virtual_h);
}

// set render target to the surface and clear (the game's objects will draw now)
if (surface_exists(render_surface)) {
    surface_set_target(render_surface);
    draw_clear(c_black);
}
