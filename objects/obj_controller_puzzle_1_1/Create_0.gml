event_inherited();

head_pointer = find_pointer_by_address("0x1111");

solution_list = ds_list_create();
ds_list_add(solution_list, "0x1111");
ds_list_add(solution_list, "0x2222");

global.puzzle_1_1_completed = false;

on_complete = function() {
	if (!global.puzzle_1_1_completed) {
		audio_play_sound(snd_puzzle_solved, 0, false, 1, 0, 1);
		global.puzzle_1_1_completed = true;
	}
};