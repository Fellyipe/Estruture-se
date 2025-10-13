/// Destroy - obj_display_manager
if (surface_exists(render_surface)) surface_free(render_surface);
if (ds_exists(valid_scales, ds_type_list)) ds_list_destroy(valid_scales);
