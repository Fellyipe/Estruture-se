if (carried_by != noone) {
    // segue o player (posicionar relativo)
    x = carried_by.x + carry_offset_x;
    y = carried_by.y + carry_offset_y;
    // opcional: ajustar depth para ficar sobre o player
    image_angle = 0;
} else if (in_tower != noone) {
    // se está encaixado na torre, fique no slot da torre
    if (instance_exists(in_tower)) {
        x = in_tower.slot_x;
        y = in_tower.slot_y;
    } else {
        // torre foi destruída: "solta" o cristal
        in_tower = noone;
    }
}
