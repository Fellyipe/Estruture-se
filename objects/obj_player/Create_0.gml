//speed = 3.0;            // pixels por frame (ajuste conforme necessário)
//use_delta = false;      // deixe false se usar room_speed fixo; true para delta_time approach

//vx = 0;
//vy = 0;


sprite[RIGHT] = spr_player_right;
sprite[UP] = spr_player_up;
sprite[LEFT] = spr_player_left;
sprite[DOWN] = spr_player_down;

face = DOWN;




/// Tenta pegar a caixa inst (assume inst existe e é obj_box_carry)
function _pickup_box(inst) {
    if (inst == noone) return false;
    if (!inst.can_be_picked) return false;

    // define side baseado na face atual do player
    carry_side = face; // face é sua variável de direção (RIGHT/LEFT/UP/DOWN)

    // verifica se o local de attach está livre (colisão com parede/outros)
    var attach = get_attach_pos(x, y, carry_side, carry_offset);
    // chamamos place_meeting no contexto da caixa (usa sua máscara)
    var blocked = would_collide_at(inst, attach.x, attach.y);


    if (blocked) {
        // não pode pegar se o espaço está ocupado
        return false;
    }

    // efetua pickup
    carrying = inst;
    inst.carried_by = id;
    // opcional reduz velocidade do player
    // move_speed *= carry_speed_factor; // ou usar variável separada
    return true;
}

/// Tenta largar a caixa no attach atual; se ocupado, tenta posições alternativas; retorna true se largou
function _drop_box() {
    if (carrying == noone) return false;
    var inst = carrying;

    // posição preferida (attach)
    var attach = get_attach_pos(x, y, carry_side, carry_offset);
    // checa ocupação usando o contexto da caixa
    var blocked = would_collide_at(inst, attach.x, attach.y);

    if (!blocked) {
        // soltar aqui
        inst.carried_by = noone;
        carrying = noone;
        carry_side = undefined;
        return true;
    }

    // tenta posições alternativas (ex: atrás do player, esquerda, direita)
    var tries = [];
    // posição atrás (oposta a carry_side)
    switch(carry_side) {
        case RIGHT: tries = [ {x:x - carry_offset, y:y}, {x:x, y:y - carry_offset}, {x:x, y:y + carry_offset} ]; break;
        case LEFT:  tries = [ {x:x + carry_offset, y:y}, {x:x, y:y - carry_offset}, {x:x, y:y + carry_offset} ]; break;
        case UP:    tries = [ {x:x, y:y + carry_offset}, {x:x - carry_offset, y:y}, {x:x + carry_offset, y:y} ]; break;
        case DOWN:  tries = [ {x:x, y:y - carry_offset}, {x:x - carry_offset, y:y}, {x:x + carry_offset, y:y} ]; break;
        default: tries = [ {x:x, y:y + carry_offset} ];
    }

    for (var i = 0; i < array_length(tries); i++) {
        var t = tries[i];
        var b = would_collide_at(inst, t.x, t.y);

        if (!b) {
            inst.carried_by = noone;
            // posicione a caixa explicitamente
            inst.x = t.x;
            inst.y = t.y;
            carrying = noone;
            carry_side = undefined;
            return true;
        }
    }

    // não há lugar para soltar - pode dar feedback (som, shake)
    // show_message("Não há espaço para soltar!");
    return false;
}
