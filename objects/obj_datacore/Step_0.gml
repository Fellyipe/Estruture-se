if (carried_by != noone) {
    // segue o player (posicionar relativo)
    x = carried_by.x + carry_offset_x;
    y = carried_by.y + carry_offset_y;
    // opcional: ajustar depth para ficar sobre o player
    image_angle = 0;
} else if (in_tower != noone) {
	mask_index = 0;
    // se está encaixado na torre, fique no slot da torre
    if (instance_exists(in_tower)) {
        x = in_tower.slot_x;
        y = in_tower.slot_y;
    } else {
        // torre foi destruída: "solta" o cristal
        in_tower = noone;
    }
}

if (in_tower == noone) {
	mask_index = spr_datacore
}

var foot_y = y + sprite_get_bbox_bottom(sprite_index) * image_yscale;
foot_y = floor(foot_y);
var wanted_depth = -foot_y;
if (depth != wanted_depth) depth = wanted_depth;

if (in_tower != noone) {
	depth = in_tower.depth - 1;
}