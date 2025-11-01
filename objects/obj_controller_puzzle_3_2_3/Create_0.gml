event_inherited();

head_pointer = find_pointer_by_address("0x99b3");

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "address", "0x99b3");
ds_map_add(m, "payload", "f6");
ds_list_add(solution_list, m);

var m = ds_map_create();
ds_map_add(m, "address", "0x9d40");
ds_map_add(m, "payload", "b2");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0xcdb4");
ds_map_add(m, "payload", "g7");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0xfa9c");
ds_map_add(m, "payload", "h8");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x4061");
ds_map_add(m, "payload", "i9");
ds_list_add(solution_list, m);

owns_solution_maps = true;

global.puzzle_3_2_3_completed = false;

function on_complete() {
	if (!global.puzzle_3_2_3_completed ) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_3_2_3_completed  = true;
	}
}

function on_descomplete() {
	if (global.puzzle_3_2_3_completed ) {
		global.puzzle_3_2_3_completed  = false;
	}
}


