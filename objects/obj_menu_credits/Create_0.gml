event_inherited();

menu_label = "CRÉDITOS";

// Apenas o botão Voltar
menu_items = [
    { 
		text: "Voltar", 
		action: function() { 
				if (instance_exists(obj_menu_main)) {
				    // se já existir, só reativa
				    instance_activate_object(obj_menu_main);
					instance_deactivate_object(obj_menu_credits);
				} else {
				    // senão, cria e já garante que o menu base fique dormindo
				    var o = instance_create_layer(0, 0, "GUI", obj_menu_main);
					instance_deactivate_object(obj_menu_credits);
				}
			}, 
	}
];

// Texto dos créditos
credit_lines = [
    "Estruture-se",
    "",
    "Desenvolvido por:",
    "Felipe Bueno",
    "",
    "Orientador:",
    "Prof. Dr. Jorge Aikes Junior",
    "",
    "Ferramenta:",
    "GameMaker Studio",
    "",
    "Ano: 2025",
    "",
    "Aperte ENTER para voltar"
];
