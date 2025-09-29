if (!active) exit;

var e_pressed = keyboard_check_pressed(ord("E"));


//var tmp = ds_list_create();

// Detecta se há alguma instância do tipo target dentro da área
var is_colliding = place_meeting(x, y, target_actor);
var actor = instance_place(x, y, target_actor);

if (actor != noone) {
    // entrou ou permanece
    if (!inside) {
        // transição: ENTER
        inside = true;
		last_actor = actor;
        
		if (is_callable(on_enter)) {
            on_enter(actor);
        }
        if (triggered_once) {
            active = false;
        }
    } else {
        // já estava dentro => STAY
        if (is_callable(on_stay)) {
            on_stay(actor);
        }
		
		// já estava dentro e apertou E => E_PRESS
        if (is_callable(on_e_press) and e_pressed) {
			on_e_press(actor);
		}
    }
} else {
    // ninguém detectado na área
    if (inside) {
        // transição: EXIT
        inside = false;
        var prev = last_actor;
        last_actor = noone;
        if (is_callable(on_exit)) {
            on_exit(prev);
        }
    }
}
