/// @description Inicializa o estado e as variáveis do pop-up (baseado em tempo).

// Parâmetros (definidos por show_popup)
text = "Mensagem Padrão";
fade_duration_seconds = 0.4;    // Duração do fade-in e fade-out (em segundos)
visible_duration_seconds = 3.0; // Duração em que fica visível (em segundos)

// Cores e Fonte
popup_color = make_color_rgb(20, 24, 30);
text_color = c_white;
font_to_use = fnt_secondary_24;

// Máquina de Estados
state = "fading_in"; // Estados: "fading_in", "visible", "fading_out"
timer = 0;           // Timer agora conta segundos, não frames
alpha = 0;           // Começa totalmente transparente
y_offset = 0;        // Deslocamento para animação de subida/descida
slide_distance = 12; // Distância que o pop-up desliza ao entrar/sair