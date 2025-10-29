// Evento Create de obj_fade_teleport

// Variáveis de controle do fade
fade_alpha = 0;      // Alfa atual (0 = transparente, 1 = totalmente opaco)
fade_speed = 0.02;   // Velocidade do fade (ajuste para mais rápido ou mais lento)
fade_state = "out";  // Estado atual do fade: "out" (escurecendo), "in" (clareando), "done" (finalizado)

// Variáveis de destino do teletransporte (serão definidas na criação da instância)
target_x = 0;
target_y = 0;
target_face = DOWN; // Use a direção que preferir como padrão
popup_called = false;

// Garante que o objeto seja persistente se o teletransporte for entre salas
// Para o seu caso na mesma sala, não é estritamente necessário, mas é uma boa prática
persistent = true;
depth = -124545

global.ui_blocked = true;