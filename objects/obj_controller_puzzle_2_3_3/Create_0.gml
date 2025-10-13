event_inherited();

head_pointer = find_pointer_by_address("0x6666");

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "address", "0x6666");
ds_map_add(m, "payload", "a1");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x7777");
ds_map_add(m, "payload", "b2");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x8888");
ds_map_add(m, "payload", "c3");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x9999");
ds_map_add(m, "payload", "d4");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x5555");
ds_map_add(m, "payload", "null");
ds_list_add(solution_list, m);

owns_solution_maps = true;

global.puzzle_2_3_3_completed = false;

on_complete = function() {
	if(!global.puzzle_2_3_3_completed) {
		show_message("Puzzle resolvido");
		global.puzzle_2_3_3_completed = true;
	}
};



//// no controller da sala, ao fechar/ir ao lobby:
//with (global.save_manager) {
//    save_room_state(room_get_name(room));
//}
//with (global.save_manager) {
//    save_slot(1); // escreve JSON no disco
//}
