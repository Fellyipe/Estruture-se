event_inherited();

solution_list = ds_list_create();


var m = ds_map_create();
ds_map_add(m, "array_id", "array_2");
ds_map_add(m, "index", 0);
ds_map_add(m, "payload", "f6");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_2");
ds_map_add(m, "index", 1);
ds_map_add(m, "payload", "b2");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_2");
ds_map_add(m, "index", 2);
ds_map_add(m, "payload", "g7");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_2");
ds_map_add(m, "index", 2);
ds_map_add(m, "payload", "h8");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "array_id", "array_2");
ds_map_add(m, "index", 2);
ds_map_add(m, "payload", "i9");
ds_map_add(m, "require_occupied", true);
ds_list_add(solution_list, m);

array_puzzle = true;

global.puzzle_3_2_4_completed = true;

function on_complete() {
	if (!global.puzzle_3_2_4_completed) {
		//show_message("Puzzle resolvido");
		global.puzzle_3_2_4_completed = true;
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
