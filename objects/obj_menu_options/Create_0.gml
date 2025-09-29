event_inherited();

/// Título
menu_label = "OPÇÕES";

// Cada entry é um struct com tipo para Step/Draw lidarem
menu_items = [
  {
    text: "Volume da Música",
    type: "slider",
    var_name: "volume_music",
    min: 0, max: 1, step: 0.05,
	action: function() {},	
  },
  {
    text: "Volume dos Efeitos Sonoros",
    type: "slider",
    var_name: "volume_sfx",
    min: 0, max: 1, step: 0.05,
	action: function() {},
  },
  {
    text: "Resolução",
    type: "select",
    var_name: "resolution",
    options: ["800×600","1024×768","1280×720"],
	action: function() {},
  },
  {
    text: "Tela Cheia",
    type: "action",
    var_name: "fullscreen",
	action: function() {
				window_set_fullscreen(!window_get_fullscreen());	
			},
  },
  {
    text: "Voltar",
    type: "action",
	var_name: "back",
    action: function() {  
				if (instance_exists(obj_menu_main)) {
				    // se já existir, só reativa
				    instance_activate_object(obj_menu_main);
					instance_deactivate_object(obj_menu_options);
				} else {
				    // senão, cria e já garante que o menu base fique dormindo
				    var o = instance_create_layer(0, 0, "GUI", obj_menu_main);
					instance_deactivate_object(obj_menu_options);
				}
			}, 
  }
];

// variáveis iniciais (podem vir de globals ou de um INI carregado)
volume_music        = 0.5;
volume_sfx          = 0.7;
resolution_index    = 2;      // 0 = 800×600, 1 = 1024×768, 2 = 1280×720


