on_enter = function() {
	with(obj_teleport_zone) {
	
		if(obj_id == "tp_workarea") {
			if (global.cur_day == "day_01" ) {
				target_x = 150;
				target_y = 180;
				target_rm = rm_puzzle_1_1;
			} else if(global.cur_day == "day_02") {
				target_x = 82;
				target_y = 180;
				target_rm = rm_puzzle_2_1;
			} else if(global.cur_day == "day_03") {
				target_x = 66;
				target_y = 180;
				target_rm = rm_puzzle_3_1;
			} else {
				active = false;
			}
		}
	}	
}



