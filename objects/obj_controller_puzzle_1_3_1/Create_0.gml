event_inherited();

head_pointer = find_pointer_by_address("0x1111");

solution_list = ds_list_create();
ds_list_add(solution_list, "0x1111");
ds_list_add(solution_list, "0x2222");
ds_list_add(solution_list, "0x3333");

x = 358;
y = -10;

global.puzzle_1_3_1_completed = false;

on_complete = function() {
	if (!global.puzzle_1_3_1_completed) {
		show_message("Puzzle resolvido");
		global.puzzle_1_3_1_completed = true;
	}
	with(obj_shock_wall) {
		if obj_id = "puzzle_wall"{ 
			x = 15000;
			y = 15000;
			solid = false;
			visible = false;
			//instance_deactivate_object(obj_shock_wall);	
		}
	}
};

on_descomplete = function() {
	show_message("Puzzle wall des-resolvido");
	with(obj_shock_wall) {
		if obj_id = "puzzle_wall" {
			x = 358;
			y = -10;
			solid = true;
			visible = true;
			//instance_activate_object(obj_shock_wall);
		}
	}
}