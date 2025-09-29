on_enter = function() {
	show_message("Porta ativada");
	with (obj_dummy_wall) {
        if (obj_id == "porta_wall") {
			instance_destroy();
        }
    }
};