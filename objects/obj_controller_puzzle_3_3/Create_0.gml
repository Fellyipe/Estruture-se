event_inherited();

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 0);
ds_map_add(m, "payload", "abc");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 1);
ds_map_add(m, "payload", "def");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 2);
ds_map_add(m, "payload", "ghi");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

array_puzzle = true;

global.puzzle_3_3_completed = false;
//global.cur_day = "day_03_puzzle";

on_complete = function() {
	if (!global.puzzle_3_3_completed) {
		global.puzzle_3_3_completed = true;
	}
}

//concept_unlock("concept.arrays");