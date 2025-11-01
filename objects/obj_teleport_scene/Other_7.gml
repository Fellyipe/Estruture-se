if(room_get_name(room) != room_get_name(target_rm)) {
	room_goto(target_rm);
	obj_player.x = target_x;
	obj_player.y = target_y;
	obj_player.face = target_face;
}

image_speed = -1;