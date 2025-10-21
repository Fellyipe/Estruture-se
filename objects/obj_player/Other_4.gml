if instance_exists(obj_controller_puzzle_base) {
	sprite[RIGHT] = spr_player_right_work;
	sprite[UP] = spr_player_up_work;
	sprite[LEFT] = spr_player_left_work;
	sprite[DOWN] = spr_player_down_work;
} else {
	sprite[RIGHT] = spr_player_right_lobby;
	sprite[UP] = spr_player_up_lobby;
	sprite[LEFT] = spr_player_left_lobby;
	sprite[DOWN] = spr_player_down_lobby;
}