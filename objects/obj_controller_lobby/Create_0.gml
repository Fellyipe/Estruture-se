event_inherited();


if (!global.popup_called) {
	show_popup_new_day("DIA 1")
}

global.popup_called = true;

if (concept_unlock("welcome_day1")) {
	with (obj_notification) {
		    instance_destroy();
	}
	
	instance_create_layer(0, 0, "GUI", obj_notification);
}

