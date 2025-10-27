event_inherited();

head_pointer = find_pointer_by_address("0x5465");

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "address", "0x5465");
ds_map_add(m, "payload", "a1");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x2d92");
ds_map_add(m, "payload", "b2");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0xa288");
ds_map_add(m, "payload", "c3");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x8818");
ds_map_add(m, "payload", "d4");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0xddbe");
ds_map_add(m, "payload", "e5");
ds_list_add(solution_list, m);

owns_solution_maps = true;

global.puzzle_2_2_completed = false;

function on_complete() {
	if (!global.puzzle_2_2_completed) {
		global.puzzle_2_2_completed = true;
	}
}

concept_unlock("concept.nodes");

//// no controller da sala, ao fechar/ir ao lobby:
//with (global.save_manager) {
//    save_room_state(room_get_name(room));
//}
//with (global.save_manager) {
//    save_slot(1); // escreve JSON no disco
//}
