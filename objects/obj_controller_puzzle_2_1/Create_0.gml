event_inherited();

head_pointer = find_pointer_by_address("0x1111");

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "address", "0x1111");
ds_map_add(m, "payload", "a1");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x2222");
ds_map_add(m, "payload", "b2");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x3333");
ds_map_add(m, "payload", "c3");
ds_list_add(solution_list, m);

owns_solution_maps = true;

global.puzzle_2_1_completed = false;
//global.cur_day = "day_02_puzzle";

on_complete = function() {
	if (!global.puzzle_2_1_completed) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_2_1_completed = true;
	}
}

on_descomplete = function() {
	if (global.puzzle_2_1_completed) {
		global.puzzle_2_1_completed = false;
	}
}


var unlock1 = concept_unlock("day2_room1_instructions");
var unlock2 = concept_unlock("day2_datacore_node_concept");
if (unlock1 || unlock2) {
	with (obj_notification) {
		    instance_destroy();
	}
	
	instance_create_layer(0, 0, "GUI", obj_notification);
}

global.already_worked = true;