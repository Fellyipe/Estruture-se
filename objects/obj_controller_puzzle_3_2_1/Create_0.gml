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
		//show_message("Puzzle resolvido");
		global.puzzle_3_2_1_completed  = true;
	}
}

concept_unlock("concept.arrays2");

//// no controller da sala, ao fechar/ir ao lobby:
//with (global.save_manager) {
//    save_room_state(room_get_name(room));
//}
//with (global.save_manager) {
//    save_slot(1); // escreve JSON no disco
//}
