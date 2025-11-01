event_inherited();

head_pointer = find_pointer_by_address("0x1192");

solution_list = ds_list_create();
ds_list_add(solution_list, "0x1192");
ds_list_add(solution_list, "0x7f40");
ds_list_add(solution_list, "0x9114");
ds_list_add(solution_list, "0xdcca");

global.puzzle_1_3_2_completed = false;

on_complete = function() {
	if (!global.puzzle_1_3_2_completed) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_1_3_2_completed = true;
	}
}

on_descomplete = function() {
	if (global.puzzle_1_3_2_completed) {
		global.puzzle_1_3_2_completed = false;
	}
}