camera_target_y = 200;

on_enter = function() {
	if (!global.puzzle_3_3_completed) {
		concept_unlock("day3_room3_concept");
		global.puzzle_3_3_completed = true;
		
		with (obj_notification) {
			    instance_destroy();
		}
	
		instance_create_layer(0, 0, "GUI", obj_notification);	
	}
}