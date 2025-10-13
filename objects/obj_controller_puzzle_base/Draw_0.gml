if show_debug_info {
	var n = instance_number(obj_pointer);
	for (var i = 0; i < n; ++i) {
	    var p = instance_find(obj_pointer, i);
	    if (!instance_exists(p)) continue;
	    var sx = p.x;
	    var sy = p.y + 40;
		draw_set_color(c_white);
	    draw_text(sx, sy, "in:" + string(p.incoming_active_count) + " eg:" + string(p.energized));
	    draw_text(sx, sy + 20, "head:" + string(p.is_head) + " emit:" + string(p.active_emitter));
	}
}