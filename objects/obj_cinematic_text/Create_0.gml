/// Create - obj_cinematic_text

// >> Texto padrão (separado por parágrafos com "\n\n")
if (!variable_instance_exists(id, "text")) {
    text = 
"Há poucos anos, campos cristalinos foram descobertos em um vale remoto fragmentos de um mineral que reagem à eletricidade de formas que a ciência ainda tenta compreender.\n\n" +
"Esses cristais, ao entrarem em contato com correntes elétricas, são capazes de canalizar grandes quantidades de energia, transportando-a através do espaço quase como se a conduzissem pelo ar. São fontes limpas, poderosas e, ao mesmo tempo, imprevisíveis.\n\n" +
"A AetherGrid nasceu dessa descoberta. Um grupo de engenheiros e pesquisadores percebeu que esses cristais poderiam revolucionar a infraestrutura energética. Com o tempo, descobriram algo ainda mais surpreendente: sob certas condições, eles também podiam preservar e retransmitir padrões de informação.\n\n" +
"Foi assim que surgiram os Datacores versões modificadas dos cristais, ajustadas para armazenar e processar dados com alta estabilidade. Eles se tornaram a base de uma nova geração de sistemas de comunicação e controle energético.\n\n" +
"Hoje, a AetherGrid mantém e opera redes inteiras baseadas nesses cristais. Mas, por mais avançada que seja a tecnologia, ela ainda é delicada. Um pequeno erro de configuração pode gerar instabilidades perigosas.\n\n" +
"Por isso, cada unidade precisa de manutenção constante e de pessoas qualificadas para lidar com elas. Técnicos treinados, com reflexos rápidos e raciocínio preciso, são enviados para dentro das unidades de manutenção... e é aí que entra você!";
}

// >> NOVO: Processamento de parágrafos
paragraphs = string_split(text, "\n\n");
current_paragraph_index = 0;

// >> Configurações da UI
panel_sprite = spr_panel;
font = fnt_secondary_18;
next_room = rm_lobby;

panel_w_scale = 0.8; 
panel_h_scale = 0.85;

// >> Configurações de Animação (baseadas em tempo)
fade_duration_seconds = 1.5;
overlay_target_alpha = 0.85;

// >> Efeito Typewriter (Máquina de Escrever)
chars_per_second = 40;
text_current_length = 0; // Agora controla o comprimento do parágrafo atual

// >> Estado
_state = "fading_in";
timer = 0;

// >> Bloqueia UI e define som
global.ui_blocked = true;
snd_confirm = noone;