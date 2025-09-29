on_enter = function(actor) {
	show_message(object_get_name(actor.object_index) + " entrou");
	with (obj_trigger_zone) {
        if (obj_id == "porta") {
			active = true;
        }
    }
}
