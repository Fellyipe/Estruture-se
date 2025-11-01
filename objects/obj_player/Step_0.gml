//var zoom_speed = .1;
//view_zoom += keyboard_check(vk_numpad8) * zoom_speed;
//view_zoom -= keyboard_check(vk_numpad2) * zoom_speed;

//view_zoom = clamp(view_zoom, 1, view_max_zoom);

//view_wport = obj_display_manager.ideal_width / view_zoom;
//view_yport = obj_display_manager.ideal_height / view_zoom; 

//view_wport = x - view_wport / 2 - 10;
//view_yport = y - view_yport / 2 - 10;



var ix = keyboard_check(vk_right) - keyboard_check(vk_left);
var iy = keyboard_check(vk_down)  - keyboard_check(vk_up);
var stopped = true;

var mag = point_distance(0,0, ix, iy);
if (mag > 0) {
    ix /= mag;
    iy /= mag;
}

if (instance_exists(obj_pauser) || global.is_paused) {
	ix = 0;
	iy = 0;
}

// Calcular deslocamento (dx, dy)
var dx = ix * move_speed;
var dy = iy * move_speed;

// se carregando, podemos aplicar fator de velocidade
if (carrying != noone) {
    dx *= carry_speed_factor;
    dy *= carry_speed_factor;
}

// --- mover em X ---
//if (dx != 0) {
//    var box_id = instance_place(x + dx, y, obj_box);
//    if (box_id != noone) {
//        // aplica impulso à caixa na direção do input
//        box_push(box_id, ix, iy, move_speed * 1.2);
//        stopped = false; // jogador está tentando empurrar
//    }
//    else if (!place_meeting(x + dx, y, obj_wall)) {
//        x += dx;
//        stopped = false;
//    } else {
//        // tentativa passo a passo até encostar
//        var step = sign(dx);
//        var remaining = abs(dx);
//        while (remaining > 0) {
//            if (!place_meeting(x + step, y, obj_wall) && !place_meeting(x + step, y, obj_box)) {
//                x += step;
//                remaining -= 1;
//            } else {
//                break;
//            }
//        }
//    }
//}
// --- mover em X ---
if (dx != 0) {
    var step = sign(dx);
    var remaining = abs(dx);

    while (remaining > 0) {
        var nx = x + step;
        var ny = y;

        // 1) colisão com paredes normais?
		if (place_meeting(nx, ny, obj_wall) || place_meeting(nx, ny, obj_static_solid)) {
		    break; // Parede sempre bloqueia
		}
		
		var porta_id = instance_place(nx, ny, obj_door);
        // Se existe uma porta na frente E ela está trancada...
        if (porta_id != noone) {
			if (porta_id.locked) {
				break; // ...trate como uma parede e pare.
			}
        }
		
		

		// 1.5) colisão com sólidos especiais (como cristais)?
		var solid_instance = instance_place(nx, ny, obj_movable_solid);

		if (solid_instance != noone) {
		    // Colidimos com um objeto sólido. Vamos investigar...
			if (variable_instance_exists(solid_instance, "in_tower")) { 
			    if (solid_instance.in_tower == noone) {
			        break;
			    }
			}
		}

        // 2) existe uma caixa "pushable" (obj_box) na frente?
        var box_id = instance_place(nx, ny, obj_box);

        // 3) existe alguma obj_box_carry na frente (pode ser a que estou carregando) ?
        var box_carry_id = instance_place(nx, ny, obj_box_carry);

        // Se achou uma obj_box_carry diferente da que eu carrego, trata como sólido
        if (box_carry_id != noone && box_carry_id != carrying) {
            // impossível atravessar
            break;
        }

        // Se há uma obj_box (empurrável)
        if (box_id != noone) {
            // se eu estou carregando, NÃO empurro (bloqueio)
            if (carrying != noone) {
                break;
            } else {
                // empurra a caixa e não entra no espaço dela
                box_push(box_id, ix, iy, move_speed * 1.2);
                stopped = false;
                break;
            }
        }

        // 4) se estou carregando, verificar se a posição da caixa ao mover para nx,ny fica livre
        //if (carrying != noone) {
		//	if (carrying.object_index != obj_crystal || carrying.object_index != obj_datacore) {
	    //        var attach = get_attach_pos(nx, ny, carry_side, carry_offset);
		//		var blocked = would_collide_at(carrying, attach.x, attach.y);

	    //        if (blocked) {
	    //            // mover na direção X faria a caixa bater → bloqueia movimento
	    //            break;
	    //        }
		//	}
        //}

        // 5) tudo limpo: move 1px
        x = nx;
        remaining -= 1;
        stopped = false;
    }
}


//// --- mover em Y ---
//if (dy != 0) {
//    var box_id = instance_place(x, y + dy, obj_box);
//    if (box_id != noone) {
//        box_push(box_id, ix, iy, move_speed * 1.2);
//        stopped = false;
//    }
//    else if (!place_meeting(x, y + dy, obj_wall)) {
//        y += dy;
//        stopped = false;
//    } else {
//        var step2 = sign(dy);
//        var remaining2 = abs(dy);
//        while (remaining2 > 0) {
//            if (!place_meeting(x, y + step2, obj_wall) && !place_meeting(x, y + step2, obj_box)) {
//                y += step2;
//                remaining2 -= 1;
//            } else {
//                break;
//            }
//        }
//    }
//}
// --- mover em Y ---
if (dy != 0) {
    var step2 = sign(dy);
    var remaining2 = abs(dy);

    while (remaining2 > 0) {
        var nx2 = x;
        var ny2 = y + step2;

        // 1) colisão com paredes normais?
		if (place_meeting(nx2, ny2, obj_wall) || place_meeting(nx2, ny2, obj_static_solid)) {
		    break; // Parede sempre bloqueia
		}

		// 1.5) colisão com sólidos especiais (como cristais)?
		var solid_instance = instance_place(nx2, ny2, obj_movable_solid);
		
		var porta_id = instance_place(nx2, ny2, obj_door);
        // Se existe uma porta na frente E ela está trancada...
        if (porta_id != noone) {
			if (porta_id.locked) {
				break; // ...trate como uma parede e pare.
			}
        }

		if (solid_instance != noone) {
		    // Colidimos com um objeto sólido. Vamos investigar...
			if (variable_instance_exists(solid_instance, "in_tower")) { 
			    if (solid_instance.in_tower == noone) {
			        break;
			    }
			}
		}

        // existe uma obj_box na frente no eixo Y?
        var box_id_y = instance_place(nx2, ny2, obj_box);
        var box_carry_id_y = instance_place(nx2, ny2, obj_box_carry);

        if (box_carry_id_y != noone && box_carry_id_y != carrying) {
            break;
        }

        if (box_id_y != noone) {
            if (carrying != noone) {
                break;
            } else {
                // empurra a caixa e não entra no espaço dela
                box_push(box_id_y, ix, iy, move_speed * 1.2);
                stopped = false;
                break;
            }
        }


        // mover 1px
        y = ny2;
        remaining2 -= 1;
        stopped = false;
    }
}




// Atualiza o sprite
if iy == 0 {
	if ix > 0 {face = RIGHT};
	if ix < 0 {face = LEFT};
}
if ix > 0 && face == LEFT {face = RIGHT};
if ix < 0 && face == RIGHT {face = LEFT};

if ix == 0 {
	if iy > 0 {face = DOWN};
	if iy < 0 {face = UP};
}
if iy > 0 && face == UP {face = DOWN};
if iy < 0 && face == DOWN {face = UP};

if (carrying != noone) sprite_index = sprite_carrying[face] else sprite_index = sprite[face];

// atribui a máscara de colisão do sprite para baixo, como máscara geral
mask_index = sprite[DOWN]

// Animação parada
if stopped {
	image_index = 0;
}


/// Step (obj_player ou objeto que precisa ser depth-sorted)

var foot_y = y + sprite_get_bbox_bottom(sprite_index) * image_yscale;
foot_y = floor(foot_y);
var wanted_depth = -foot_y;
if (depth != wanted_depth) depth = wanted_depth;


if (carrying != noone) {
	carrying.depth = face != UP ? wanted_depth -1 : wanted_depth + 1;
}


