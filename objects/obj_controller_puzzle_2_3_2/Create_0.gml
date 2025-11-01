event_inherited();

head_pointer = find_pointer_by_address("0xd0d7");

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "address", "0xd0d7");
ds_map_add(m, "payload", "a1");
ds_list_add(solution_list, m);


owns_solution_maps = true;

global.puzzle_2_3_2_completed = false;

on_complete = function() {
	if (!global.puzzle_2_3_2_completed) {
		audio_play_sound(snd_puzzle_solved_unused, 0, false, 1, 0, 1);
		global.puzzle_2_3_2_completed = true;
	}
}

on_descomplete = function() {
	if (!global.puzzle_2_3_2_completed) {
		global.puzzle_2_3_2_completed = true;
	}
}



//// no controller da sala, ao fechar/ir ao lobby:
//with (global.save_manager) {
//    save_room_state(room_get_name(room));
//}
//with (global.save_manager) {
//    save_slot(1); // escreve JSON no disco
//}
