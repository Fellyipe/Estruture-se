slot_offset_x = 0;
slot_offset_y = -7;
slot_x = x + slot_offset_x;
slot_y = y + slot_offset_y;

//payload = "null";
//prompt_distance = 48;
//label_font = fnt_menu;
//label_color = c_white;
//datacore_inst = noone;
//target_inst = noone;
//incoming_active_count = 0;
//overloaded = false;
//overload_cooldown = 0;
//overload_cooldown_max = 2000;
//accepts_crystal = true;
//occupied = false;
//address = 0x0000;
//ishead = false;
//locked = false;
//node_label = "";

is_highlighted = false;
can_be_picked = false;


if (sprite_exists(sprite_index)) {
    sprite_bottom_offset = sprite_get_bbox_bottom(sprite_index);
} else {
    sprite_bottom_offset = 12; // fallback
}

if is_super sprite_index = spr_data_slot;

player_ref = noone;

var foot_y = y + sprite_get_bbox_bottom(sprite_index) * image_yscale
depth = -floor(foot_y);

actual_sprite = spr_data_slot;
if (is_super) {
	actual_sprite = spr_data_slot_super;
}