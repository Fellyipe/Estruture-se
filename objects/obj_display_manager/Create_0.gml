//// Display properties
//ideal_width = 0;
//ideal_height = 256;
//zoom = 1;
//max_zoom = 1;

//max_zoom = floor(display_get_width()/ ideal_width);

//aspect_ratio = display_get_width() / display_get_height();

//ideal_width = round(ideal_height * aspect_ratio);

//if(ideal_width & 1)
//	ideal_width++;
	
//for(var i=1; i<=room_last; i++) {
//	if(room_exists(i)) {
//		room_set_viewport(i, 0, true, 0, 0, ideal_width, ideal_height);
//		room_set_view_enabled(i, true);
//	}
//}

//surface_resize(application_surface, ideal_width, ideal_height);
//window_set_size(ideal_width, ideal_height);

//room_goto(room_next(room));




// Virtual resolution (altere se quiser)
virtual_w = 640;
virtual_h = 360;

// Surface handle
render_surface = noone;

// initial scale and offsets
zoom = 1;
offset_x = 0;
offset_y = 0;

// letterbox color
letterbox_color = c_black;

// build list of valid integer scales (calculated dynamically in Draw End too)
valid_scales = ds_list_create();

// helper to force nearest-neighbor for pixel art (try both API/IDE setting)
//if (function_exists(texture_set_interpolation)) {
//    texture_set_interpolation(false);
//}
// Fallback: set texture groups in the IDE with interpolation off.

// Track last window size so we can recalc only on change
_last_sw = display_get_width();
_last_sh = display_get_height();
