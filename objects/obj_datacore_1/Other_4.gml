if in_tower_node_label != "" {
	var t_inst = find_slot_by_label(in_tower_node_label)
	if t_inst != noone place_datacore_on_tower2(id, t_inst)
} else if in_tower_tower_id != "" {
	var t_inst = find_element_by_tower_id(in_tower_tower_id)
	if t_inst != noone place_datacore_on_tower2(id, t_inst)
}


