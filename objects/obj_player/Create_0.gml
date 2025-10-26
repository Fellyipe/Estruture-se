//speed = 3.0;            // pixels por frame (ajuste conforme necessário)
//use_delta = false;      // deixe false se usar room_speed fixo; true para delta_time approach

//vx = 0;
//vy = 0;


sprite[RIGHT] = spr_player_right_work;
sprite[UP] = spr_player_up_work;
sprite[LEFT] = spr_player_left_work;
sprite[DOWN] = spr_player_down_work;

face = DOWN;

view_zoom = 1;
view_max_zoom = 10;



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
	
	else {
	 return false;
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

// helper: função inline para checar se instância está "à frente" do player
function _is_a_frente(inst) {
    if (inst == noone) return false;
    var d = point_distance(x, y, inst.x, inst.y);
    if (d > pick_radius) return false;

    var vx = inst.x - x;
    var vy = inst.y - y;
    var vm = point_distance(0,0,vx,vy);
    if (vm == 0) return false;
    vx /= vm; vy /= vm;

    var fx = 0; var fy = 0;
    switch(face) {
        case RIGHT: fx = 1; fy = 0; break;
        case LEFT:  fx = -1; fy = 0; break;
        case UP:    fx = 0; fy = -1; break;
        case DOWN:  fx = 0; fy = 1; break;
    }
    var dot = vx*fx + vy*fy;
    var threshold = 0.65;
    return dot >= threshold;
}
