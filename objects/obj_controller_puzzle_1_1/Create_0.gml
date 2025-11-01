event_inherited();

head_pointer = find_pointer_by_address("0x1111");

solution_list = ds_list_create();
ds_list_add(solution_list, "0x1111");
ds_list_add(solution_list, "0x2222");

global.puzzle_1_1_completed = false;

on_complete = function() {
	if (!global.puzzle_1_1_completed) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_1_1_completed = true;
	}
};

on_descomplete = function() {
	if (global.puzzle_1_1_completed) {
		global.puzzle_1_1_completed = false;
	}
};

var unlock1 = concept_unlock("day1_room1_instructions");
var unlock2 = concept_unlock("day1_pointer_crystal")
if(unlock1 || unlock2) {
	with (obj_notification) {
	    instance_destroy();
	}
	
	instance_create_layer(0, 0, "GUI", obj_notification);
}

global.already_worked = true;

