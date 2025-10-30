on_enter = function() {
	if (global.cur_day == "day_01") {
		global.cur_day = "day_02";
		
		if (!instance_exists(obj_teleport_new_day)) {
		    var _fade_teleport = instance_create_layer(150, 150, "GUI", obj_teleport_new_day);

		    _fade_teleport.target_x = 150;
		    _fade_teleport.target_y = 456;
		    _fade_teleport.target_face = DOWN;
		}
	} else if(global.cur_day == "day_02") {
		global.cur_day = "day_03";
		if (!instance_exists(obj_teleport_new_day)) {
		    var _fade_teleport = instance_create_layer(150, 150, "GUI", obj_teleport_new_day);

		    _fade_teleport.target_x = 150;
		    _fade_teleport.target_y = 456;
		    _fade_teleport.target_face = DOWN;
		}
	} else if(global.cur_day == "day_03") {
		global.cur_day = "day_end";
		
		with(obj_player) {
			instance_destroy(self);
		}
		
		room_goto(rm_ending_scene);
	}
}