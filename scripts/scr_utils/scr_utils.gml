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