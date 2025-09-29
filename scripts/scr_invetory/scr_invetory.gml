function clone_item(item) {
    // Suporta structs e ds_maps (exemplo simples)
    var out = {};
    if (is_undefined(item)) return out;

    // Se for ds_map (exemplo de verificação simples via variável)
    // Aqui assumimos que você sabe o tipo; se for ds_map, faça:
    // out = ds_map_copy(item);

    // Se for struct, copie campos manualmente (ou use struct_copy)
    out.item_id		= item.item_id;
    out.item_name	= item.item_name;
    out.qty			= item.qty;
    out.stackable	= item.stackable;
    out.max_stack	= item.max_stack;
    out.icon		= item.icon;
    out.description	= item.description;
    out.use_fn		= item.use_fn;
	out.single_use	= item.single_use
    return out;
}


function inventory_add(item_struct) {
	// supondo global.inventory é um array de structs
	// procura slot existente se empilhável
	if (item_struct.stackable) {
	    // procurar índice por id
	    var idx = -1;
	    for (var i = 0; i < array_length(global.inventory); i++) {
	        if (global.inventory[i].item_id == item_struct.item_id) { idx = i; break; }
	    }

	    if (idx != -1) {
	        // atualiza quantidade no slot existente (respeita max_stack)
	        var slot = global.inventory[idx];
	        var can_add = min(item_struct.qty, slot.max_stack - slot.qty);
	        slot.qty += can_add;
	        global.inventory[idx] = slot;

	        var remaining = item_struct.qty - can_add;
	        while (remaining > 0 && array_length(global.inventory) < global.inventory_max) {
	            var part = clone_item(item_struct);
	            part.qty = min(remaining, part.max_stack);
	            array_push(global.inventory, part);
	            remaining -= part.qty;
	        }
	        return true;
	    }
	}

	// se não empilha ou slot não encontrado, adiciona novo slot se houver espaço
	if (array_length(global.inventory) < global.inventory_max) {
	    var new_item = struct_copy(it); // <--- aqui é o correto
	    array_push(global.inventory, new_item);
	    return true;
	}

	// inventário cheio
	return false;
}




function inventory_use(index) {
	if (index < 0 || index >= array_length(global.inventory)) return false;
	var it = global.inventory[index];

	// se existir use_script (string), chama via script_execute
	/*if (is_string(it.use_script) && it.use_script != "") {
	    script_execute(asset_get_index(it.use_script), index);
	} else */if (is_callable(it.use_fn)) {
	    it.use_fn(index);
	} 
	if (it.single_use){
	    // comportamento padrão: se stackable, decrementar
	    if (it.stackable) {
	        it.qty -= 1;
	        if (it.qty <= 0) {
	            // remove slot
	            array_delete(global.inventory, index, 1);
	        } else {
	            global.inventory[index] = it;
	        }
	    } else {
	        // itens não empilháveis são removidos ao usar
	        array_delete(global.inventory, index, 1);
	    }
	}
	return true;
}


function inventory_drop(index) {
	if (index < 0 || index >= array_length(global.inventory)) return false;
	// opcional: spawn item físico no mundo
	var it = global.inventory[index];
	// spawn exemplo: instance_create_layer(player.x+16, player.y, "Instances", obj_item_pickup)
	// você precisaria criar obj_item_pickup com dados do item
	array_delete(global.inventory, index, 1);
	return true;
}