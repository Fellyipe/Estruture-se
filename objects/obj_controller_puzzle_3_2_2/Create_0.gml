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
ds_map_add(m, "payload", "c3");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 2);
ds_map_add(m, "payload", "d4");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_1");
ds_map_add(m, "index", 3);
ds_map_add(m, "payload", "e5");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

array_puzzle = true;

global.puzzle_3_2_2_completed = false;

function on_complete() {
	if (!global.puzzle_3_2_2_completed) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_3_2_2_completed = true;
	}
}

function on_descomplete() {
	if (global.puzzle_3_2_2_completed) {
		global.puzzle_3_2_2_completed = false;
	}
}

