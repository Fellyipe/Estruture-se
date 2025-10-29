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
		//show_message("Puzzle resolvido");
		global.puzzle_3_2_3_completed  = true;
	}
}

//concept_unlock("concept.arrays2");

//// no controller da sala, ao fechar/ir ao lobby:
//with (global.save_manager) {
//    save_room_state(room_get_name(room));
//}
//with (global.save_manager) {
//    save_slot(1); // escreve JSON no disco
//}
