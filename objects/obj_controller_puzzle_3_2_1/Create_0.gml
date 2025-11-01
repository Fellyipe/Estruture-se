event_inherited();

head_pointer = find_pointer_by_address("0xce3f");

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "address", "0xce3f");
ds_map_add(m, "payload", "a1");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x1e08");
ds_map_add(m, "payload", "c3");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0xfa6a");
ds_map_add(m, "payload", "d4");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x323e");
ds_map_add(m, "payload", "e5");
ds_list_add(solution_list, m);

owns_solution_maps = true;

global.puzzle_3_2_1_completed = false;

function on_complete() {
	if (!global.puzzle_3_2_1_completed ) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_3_2_1_completed  = true;
	}
}

function on_descomplete() {
	if (global.puzzle_3_2_1_completed ) {
		global.puzzle_3_2_1_completed  = false;
	}
}

var unlock1 = concept_unlock("day3_room2_instructions");
var unlock2 = concept_unlock("day3_room2_concept");

if(unlock1 || unlock2) {
	with (obj_notification) {
	    instance_destroy();
	}
	
	instance_create_layer(0, 0, "GUI", obj_notification);
}
