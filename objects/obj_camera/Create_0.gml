// Desativa o comportamento padrão da câmera do GameMaker
view_enabled = true;
view_set_visible(0, true);

// Pega o ID da câmera ativa
camera = view_get_camera(0);

// Pega as dimensões da view/câmera
view_w = camera_get_view_width(camera);
view_h = camera_get_view_height(camera);

// Variáveis para a posição da câmera (para suavização)
cam_x = x;
cam_y = y;

// Alvo que a câmera deve seguir
target = obj_player; // Alvo inicial é o jogador

// Velocidade da suavização (0.01 = lento, 1 = instantâneo)
follow_speed = 0.07;