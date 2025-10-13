function get_pointer_by_address(address) {
	var _n = instance_number(obj_pointer);
	for (var i = 0; i < _n; ++i) {
	    var inst = instance_find(obj_pointer, i);
	    if (variable_instance_exists(inst, "address")) {
	        if (inst.address == address) return inst;
	    }
	}
	return noone;
}



function screen_to_virtual(mx, my) {
	var vx = (mx - obj_display_manager.offset_x) / obj_display_manager.zoom;
	var vy = (my - obj_display_manager.offset_y) / obj_display_manager.zoom;
	return { x: vx, y: vy };
}

function virtual_to_screen(vx, vy) {
	var sx = vx * obj_display_manager.zoom + obj_display_manager.offset_x;
	var sy = vy * obj_display_manager.zoom + obj_display_manager.offset_y;
	return { x: sx, y: sy };
}