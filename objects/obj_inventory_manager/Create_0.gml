// Exemplo de item (struct)
var item = {
    item_id: "potion_small",        // id único
    item_name: "Poção inútil",
    icon: spr_useless_potion,    // sprite para desenhar
    qty: 3,                    // quantidade
    stackable: true,           // se pode empilhar
    max_stack: 9,              // limite por slot (se empilhável)
    description: "Não faz nada.",
    use_fn: function() {show_message("Nada aconteceu");}, // nome de script para executar ao usar (opcional)
	single_use: true,
};
var item2 = {
    item_id: "key",        // id único
    item_name: "Chave",
    icon: spr_useless_key,    // sprite para desenhar
    qty: 1,                    // quantidade
    stackable: false,           // se pode empilhar
    max_stack: 1,              // limite por slot (se empilhável)
    description: "Abre uma porta.",
    use_fn: function() {show_message("Porta se abriu");}, // nome de script para executar ao usar (opcional)
	single_use: false,
};


global.inventory = [];       // array de structs como o exemplo acima
global.inventory_max = 8;

// helper: procura item por id, retorna índice ou -1
function inv_index_of(_item_id) {
    for (var i = 0; i < array_length(global.inventory); ++i) {
        if (global.inventory[i].id == _item_id) return i;
    }
    return -1;
}

array_push(global.inventory, clone_item(item));
array_push(global.inventory, clone_item(item2));

