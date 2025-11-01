event_inherited();

head_pointer = find_pointer_by_address("0x1d17");

solution_list = ds_list_create();
ds_list_add(solution_list, "0x1d17");
ds_list_add(solution_list, "0x6856");
ds_list_add(solution_list, "0x9f4b");
ds_list_add(solution_list, "0x434d");
ds_list_add(solution_list, "0xe840");


global.puzzle_1_2_completed = false;

on_complete = function() {
	if (!global.puzzle_1_2_completed) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_1_2_completed = true;
	}
};

on_descomplete = function() {
	if (global.puzzle_1_2_completed) {
		global.puzzle_1_2_completed = false;
	}
};

if (concept_unlock("day1_pointer_concept")) {

	with (obj_notification) {
		    instance_destroy();
	}
	
	instance_create_layer(0, 0, "GUI", obj_notification);
}