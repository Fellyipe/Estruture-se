event_inherited();

head_pointer = find_pointer_by_address("0x1111");

solution_list = ds_list_create();

var m = ds_map_create();
ds_map_add(m, "address", "0x1111");
ds_map_add(m, "payload", "abc");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x2222");
ds_map_add(m, "payload", "def");
ds_list_add(solution_list, m);

m = ds_map_create();
ds_map_add(m, "address", "0x3333");
ds_map_add(m, "payload", "ghi");
ds_list_add(solution_list, m);

owns_solution_maps = true;

global.puzzle_2_1_completed = false;

on_complete = function() {
	if (!global.puzzle_2_1_completed) {
		show_message("Puzzle resolvido");
		global.puzzle_2_1_completed = true;
	}
}