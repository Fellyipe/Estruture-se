if room == target_rm && image_index < 1 {
	global.ui_blocked = false;
	instance_destroy();
}