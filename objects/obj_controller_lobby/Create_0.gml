event_inherited();


if (!global.popup_called) {
	show_popup_new_day("DIA 1")
}

global.popup_called = true;

concept_unlock("intro_lore");
concept_unlock("welcome_day1");

show_popup("Aperte Tab para abrir o tablet", 6);