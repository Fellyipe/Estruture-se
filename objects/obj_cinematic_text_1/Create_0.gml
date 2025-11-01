	/// Create - obj_cinematic_text
	// Texto padrão (substituível ao instanciar)
	if (!variable_instance_exists(self, "text")) {
	    text = 
	"Há poucos anos, campos cristalinos foram descobertos em um vale remoto - fragmentos de um mineral que reagem à eletricidade de formas que a ciência ainda tenta compreender.\n\n" +
	"Esses cristais, ao entrarem em contato com correntes elétricas, são capazes de canalizar grandes quantidades de energia, transportando-a através do espaço quase como se a conduzissem pelo ar. São fontes limpas, poderosas e, ao mesmo tempo, imprevisíveis.\n\n" +
	"A AetherGrid nasceu dessa descoberta. Um grupo de engenheiros e pesquisadores percebeu que esses cristais poderiam revolucionar a infraestrutura energética. Com o tempo, descobriram algo ainda mais surpreendente: sob certas condições, eles também podiam preservar e retransmitir padrões de informação.\n\n" +
	"Foi assim que surgiram os Datacores - versões modificadas dos cristais, ajustadas para armazenar e processar dados com alta estabilidade. Eles se tornaram a base de uma nova geração de sistemas de comunicação e controle energético.\n\n" +
	"Hoje, a AetherGrid mantém e opera redes inteiras baseadas nesses cristais. Mas, por mais avançada que seja a tecnologia, ela ainda é delicada. Um pequeno erro de configuração pode gerar instabilidades perigosas.\n\n" +
	"Por isso, cada unidade precisa de manutenção constante - e de pessoas qualificadas para lidar com elas. Técnicos treinados, com reflexos rápidos e raciocínio preciso, são enviados para dentro das unidades de manutenção... e é aí que entra você!";
	}

	panel_sprite = spr_panel;

	font = fnt_secondary_24;

	next_room = rm_lobby;

	// Aparência e estado
	overlay_alpha = 0;
	overlay_target = 0.78;
	fade_speed = 0.04;
	panel_pad = 28;
	panel_max_w = display_get_width() * 0.85;
	panel_color = make_color_rgb(14,16,20);
	panel_alpha = 0.94;
	text_color = c_white;

	_state = "fading_in"; // fading_in / visible / fading_out
	_input_locked = false;

	// bloqueia UI global (se você usa)
	global.ui_blocked = true;

	// som de confirmação opcional (defina antes de instanciar se quiser)
	//if (!variable_instance_exists(self, "snd_confirm")) 
	snd_confirm = noone;
