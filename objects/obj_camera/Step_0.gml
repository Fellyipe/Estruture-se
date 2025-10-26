// 1. Garante que o alvo (jogador) existe para evitar crashs
if (!instance_exists(target)) {
    exit; // Se o jogador não existe, não faz nada
}

// 2. Define as coordenadas do alvo padrão (posição do jogador)
var target_x = target.x;
var target_y = target.y;

// 3. Verifica se o jogador está dentro de uma "zona de janela"
var trigger = instance_find(obj_trigger_zone, 0);

if (trigger.inside) {
    // SE ESTIVER NA ZONA:
    // O alvo Y da câmera muda para o valor definido na instância do trigger!
    target_y = trigger.camera_target_y;
    
    // O alvo X continua seguindo o jogador para que a câmera se mova lateralmente
    target_x = target.x;
    
} else {
    // SE NÃO ESTIVER NA ZONA:
    // O alvo volta a ser a posição normal do jogador
    target_x = target.x;
    target_y = target.y;
}

// 4. Suaviza o movimento da câmera usando lerp (interpolação linear)
// Isso evita que a câmera "salte" bruscamente para a nova posição
cam_x = lerp(cam_x, target_x, follow_speed);
cam_y = lerp(cam_y, target_y, follow_speed);

// 5. Calcula a posição final da câmera, garantindo que ela não saia dos limites da sala
// O "clamp" impede que a câmera mostre áreas fora da sala
var final_cam_x = clamp(cam_x - view_w / 2, 0, room_width - view_w);
var final_cam_y = clamp(cam_y - view_h / 2, 0, room_height - view_h);

// 6. Atualiza a posição da câmera
camera_set_view_pos(camera, final_cam_x, final_cam_y);
