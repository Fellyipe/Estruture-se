event_inherited();

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 0);
ds_map_add(m, "payload", "a1");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 1);
ds_map_add(m, "payload", "b2");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 2);
ds_map_add(m, "payload", "c3");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

array_puzzle = true;

global.puzzle_3_1_completed = false;
//global.cur_day = "day_03_puzzle";

on_complete = function() {
	if (!global.puzzle_3_1_completed) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_3_1_completed = true;
	}
}

on_descomplete = function() {
	if (global.puzzle_3_1_completed) {
		global.puzzle_3_1_completed = false;
	}
}


var unlock1 = concept_unlock("day3_array_concept");
var unlock2 = concept_unlock("day3_room1_instructions");
var unlock3 = concept_unlock("day3_array_overview");

if(unlock1 || unlock2 || unlock3) {
	with (obj_notification) {
	    instance_destroy();
	}
	instance_create_layer(0, 0, "GUI", obj_notification);
}


global.already_worked = true;