if (connected_pointer_address != "") {
	var inst = find_pointer_by_address(connected_pointer_address) 
	if (inst != noone) {
		if(!inst.energized) {
			image_index = 0;
		}
	} else {
		image_index = 0;
	}
} else {
	image_index = 0;
}