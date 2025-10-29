event_inherited();

head_pointer = find_pointer_by_address("0xf8a8");

solution_list = ds_list_create();
ds_list_add(solution_list, "0xf8a8");
ds_list_add(solution_list, "0x1947");
ds_list_add(solution_list, "0x569b");

x = 358;
y = -10;

global.puzzle_1_3_1_completed = false;

on_complete = function() {
	if (!global.puzzle_1_3_1_completed) {
		audio_play_sound(snd_puzzle_solved, 0, false, 1, 0, 1);
		global.puzzle_1_3_1_completed = true;
	}
	with(obj_lightning_wall) {
		if obj_id = "puzzle_wall"{ 
			x = 353;
			y = 45;
		}
	}
};

on_descomplete = function() {
	with(obj_lightning_wall) {
		if obj_id = "puzzle_wall" {
			x = 15000;
			y = 15000;
		}
	}
}