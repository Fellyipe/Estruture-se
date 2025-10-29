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
		global.puzzle_3_1_completed = true;
	}
}


concept_unlock("day1_pointer_crystal");
concept_unlock("day1_room1_instructions");
concept_unlock("day1_pointer_concept");
concept_unlock("day1_room3_overview");
concept_unlock("day2_datacore_node_concept");
concept_unlock("day2_room1_instructions");
concept_unlock("day2_node_concept");
concept_unlock("day2_room3_overview");
concept_unlock("day3_array_overview");
concept_unlock("day2_room1_instructions");
concept_unlock("day3_array_concept");
