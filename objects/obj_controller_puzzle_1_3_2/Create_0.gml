event_inherited();

head_pointer = find_pointer_by_address("0x4444");

solution_list = ds_list_create();
ds_list_add(solution_list, "0x4444");
ds_list_add(solution_list, "0x5555");
ds_list_add(solution_list, "0x6666");
ds_list_add(solution_list, "0x7777");

global.puzzle_1_3_2_completed = false;

on_complete = function() {
	if (!global.puzzle_1_3_2_completed) {
		show_message("Puzzle resolvido");
		global.puzzle_1_3_2_completed = true;
	}
}