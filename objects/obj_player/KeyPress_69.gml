// SEGUNDA VERSÃO
//if (carrying == noone) {
//    // procura a caixa mais próxima à frente do jogador dentro do pick_radius
//    var best = noone;
//    var bestd = pick_radius + 1;

//    var inst_count = instance_number(obj_box_carry);
//    for (var i = 0; i < inst_count; i++) {
//        var inst = instance_find(obj_box_carry, i);
//        if (!instance_exists(inst)) continue;
//        if (!inst.can_be_picked) continue; // respeita flag da caixa

//        var d = point_distance(x, y, inst.x, inst.y);
//        if (d > pick_radius) continue;

//        // vetor normalizado jogador -> caixa
//        var vx = inst.x - x;
//        var vy = inst.y - y;
//        var vm = point_distance(0, 0, vx, vy);
//        if (vm == 0) continue;
//        vx /= vm; vy /= vm;

//        // vetor da face do jogador
//        var fx = 0, fy = 0;
//        switch (face) {
//            case RIGHT: fx = 1; fy = 0; break;
//            case LEFT:  fx = -1; fy = 0; break;
//            case UP:    fx = 0; fy = -1; break;
//            case DOWN:  fx = 0; fy = 1; break;
//        }

//        // dot product -> 1 = exatamente na frente, 0 = lateral, -1 = atrás
//        var dot = vx * fx + vy * fy;

//        var threshold = 0.65; // ajustável: 0.7 é um cone mais estreito, 0.5 mais largo
//        if (dot < threshold) continue; // não está suficientemente "à frente"

//        // (opcional) testar também se a posição de attach está livre
//        var attach = get_attach_pos(x, y, face, carry_offset);
//		var attach_blocked = would_collide_at(inst, attach.x, attach.y);
//        if (attach_blocked) continue; // impossível pegar porque ao anexar, bateria

//        // prefira a caixa mais próxima dentro do cone
//        if (d < bestd) {
//            best = inst;
//            bestd = d;
//        }
//    }

//    if (best != noone) {
//        // tenta pegar com sua função existente
//        if (!_pickup_box(best)) {
//            // feedback se falhar (som, shake)
//        } else {
//            // sucesso (som/anim)
//        }
//    } else {
//        // nenhuma caixa válida à frente
//        // opcional: dar feedback (som fraco)
//    }
//} else {
//    // já carregando -> tenta soltar
//    _drop_box();
//}






//// Se NÃO está carregando nada -> tentamos pegar algo
//if (carrying == noone) {
//    // 1) tentar pegar cristal que esteja encaixado numa torre próxima (prioridade)
//    var t = instance_nearest(x, y, obj_pointer);
//    if (t != noone && _is_a_frente(t) && point_distance(x,y,t.x,t.y) <= pick_radius) {
//        // se torre tem cristal, pegue dele
//        if (t.crystal_inst != noone) {
//            // usa script para retirar cristal da torre e dar ao player
//            if (take_from_tower(t, id)) {
//                // sucesso (som/feedback feito no script)
//                // marque carry_side etc se quiser
//                return; // já pegou
//            }
//        }
//    }

//    // 2) procurar cristais soltos no chão (obj_crystal)
//    var best = noone; var bestd = pick_radius + 1;
//    var cntc = instance_number(obj_crystal);
//    for (var i = 0; i < cntc; i++) {
//        var inst = instance_find(obj_crystal, i);
//        if (!instance_exists(inst)) continue;
//        if (!inst.can_be_picked) continue;
//        if (!_is_a_frente(inst)) continue;
//        var d = point_distance(x, y, inst.x, inst.y);
//        if (d < bestd) { best = inst; bestd = d; }
//    }
//    if (best != noone) {
//        // reutiliza sua função de pickup (presume que ela funciona com objetos genéricos)
//        if (!_pickup_box(best)) {
//            // falhou: feedback opcional
//        } else {
//            // sucesso
//        }
//        // pronto, acabou a interação deste E
//        return;
//    }

//    // 3) procurar caixas (obj_box_carry) no chão (se nada mais foi encontrado)
//    var best2 = noone; var bestd2 = pick_radius + 1;
//    var cntb = instance_number(obj_box_carry);
//    for (var j = 0; j < cntb; j++) {
//        var inst2 = instance_find(obj_box_carry, j);
//        if (!instance_exists(inst2)) continue;
//        if (!inst2.can_be_picked) continue;
//        if (!_is_a_frente(inst2)) continue;
//        var d2 = point_distance(x, y, inst2.x, inst2.y);
//        if (d2 < bestd2) { best2 = inst2; bestd2 = d2; }
//    }
//    if (best2 != noone) {
//        if (!_pickup_box(best2)) {
//            // falha pegando caixa
//        } else {
//            // sucesso
//        }
//        return;
//    }

//    // nada encontrado -> feedback opcional
//}
//else {
//    // Já está carregando algo: decidir comportamento com base no tipo do objeto carregado
//    var carried_obj = carrying;

//    // se carregar cristal: tentar encaixar em torre próxima (prioridade)
//    if (instance_exists(carried_obj) && carried_obj.object_index == obj_crystal) {
//        var tnear = instance_nearest(x, y, obj_pointer);
//        if (tnear != noone && _is_a_frente(tnear) && point_distance(x,y,tnear.x,tnear.y) <= pick_radius) {
//            // tenta encaixar via script (retorna true/false)
//            if (place_crystal_on_tower(id, tnear)) {
//                // encaixou com sucesso
//                return;
//            } else {
//                // falhou (slot ocupado) -> fallback: tentar largar no chão
//                // deixar cair abaixo
//            }
//        }
//        // se não encontrou torre ou não encaixou: largar no chão padrão
//        if (_drop_box()) {
//            return;
//        } else {
//            // não conseguiu largar; feedback
//        }
//    }
//    else {
//        // não é cristal (provavelmente caixa) -> uso do _drop_box
//        if (_drop_box()) {
//            return;
//        } else {
//            // não conseguiu largar
//        }
//    }
//}

if(global.is_paused || global.ui_blocked) exit;

// Helper inline _is_a_frente já existe no seu código — estamos usando ele

// Se NÃO está carregando nada -> tentamos pegar algo
if (carrying == noone) {
  // 0) Prioridade: tentar pegar DATACORE de um data_slot próximo
  var slot_near = instance_nearest(x, y, obj_data_slot);
  if (
    slot_near != noone &&
    _is_a_frente(slot_near) &&
    point_distance(x, y, slot_near.x, slot_near.y) <= pick_radius &&
	!slot_near.locked
  ) {
    // se o slot tem um datacore, pegue dele
    if (
      variable_instance_exists(slot_near, "datacore_inst") &&
      slot_near.datacore_inst != noone
    ) {
      if (take_datacore_from_tower(slot_near, id)) {
        return; // já pegou, fim da interação
      }
    }
  }

  // 0.5) tentar pegar DATACORE de um array_element próximo
  var element_near = instance_nearest(x, y, obj_array_element);
  if (
    element_near != noone &&
    _is_a_frente(element_near) &&
    point_distance(x, y, element_near.x, element_near.y) <= pick_radius &&
	!element_near.locked
  ) {
    // se o slot tem um datacore, pegue dele
    if (
      variable_instance_exists(element_near, "datacore_inst") &&
      element_near.datacore_inst != noone
    ) {
      if (take_datacore_from_tower(element_near, id)) {
        return; // já pegou, fim da interação
      }
    }
  }

  // 1) tentar pegar cristal que esteja encaixado numa tower (comportamento antigo)
  var t = instance_nearest(x, y, obj_pointer);
  if (
    t != noone &&
    _is_a_frente(t) &&
    point_distance(x, y, t.x, t.y) <= pick_radius &&
	!t.locked
  ) {
    if (t.crystal_inst != noone) {
      if (take_from_tower(t, id)) return;
    }
  }

  // 2) procurar datacores soltos no chão (obj_datacore) — prioridade acima de caixas
  var best_dc = noone;
  var bestd_dc = pick_radius + 1;
  var ncores = instance_number(obj_datacore);
  for (var i = 0; i < ncores; ++i) {
    var inst = instance_find(obj_datacore, i);
    if (!instance_exists(inst)) continue;
    if (!inst.can_be_picked) continue;
    if (!_is_a_frente(inst)) continue;
    var d = point_distance(x, y, inst.x, inst.y);
    if (d < bestd_dc) {
      best_dc = inst;
      bestd_dc = d;
    }
  }
  if (best_dc != noone) {
    // reutiliza sua função de pickup (presume que ela funciona com objetos genéricos)
    if (!_pickup_box(best_dc)) {
      // falhou: feedback opcional
    } else {
      // sucesso
    }
    // pronto, acabou a interação deste E
    return;
  }

  // 3) procurar cristais soltos no chão (obj_crystal) — comportamento antigo
  var best = noone;
  var bestd = pick_radius + 1;
  var cntc = instance_number(obj_crystal);
  for (var i = 0; i < cntc; i++) {
    var inst = instance_find(obj_crystal, i);
    if (!instance_exists(inst)) continue;
    if (!inst.can_be_picked) continue;
    if (!_is_a_frente(inst)) continue;
    var d = point_distance(x, y, inst.x, inst.y);
    if (d < bestd) {
      best = inst;
      bestd = d;
    }
  }
  if (best != noone) {
    // reutiliza sua função de pickup (presume que ela funciona com objetos genéricos)
    if (!_pickup_box(best)) {
      // falhou: feedback opcional
    } else {
      // sucesso
    }
    // pronto, acabou a interação deste E
    return;
  }

  // 4) procurar caixas (obj_box_carry)
  var best2 = noone;
  var bestd2 = pick_radius + 1;
  var cntb = instance_number(obj_box_carry);
  for (var j = 0; j < cntb; j++) {
    var inst2 = instance_find(obj_box_carry, j);
    if (!instance_exists(inst2)) continue;
    if (!inst2.can_be_picked) continue;
    if (!_is_a_frente(inst2)) continue;
    var d2 = point_distance(x, y, inst2.x, inst2.y);
    if (d2 < bestd2) {
      best2 = inst2;
      bestd2 = d2;
    }
  }
  if (best2 != noone) {
    if (!_pickup_box(best2)) {
      // falha pegando caixa
    } else {
      // sucesso
    }
    return;
  }

  // nada encontrado -> feedback opcional
} else {
  // Já está carregando algo: decidir comportamento com base no tipo do objeto carregado
  var carried_obj = carrying;

  // se estiver carregando um datacore
  if (
    instance_exists(carried_obj) &&
    carried_obj.object_index == obj_datacore
  ) {
    // tenta encaixar em data_slot próximo (prioridade)
    var slot_target = instance_nearest(x, y, obj_data_slot);
    if (
      slot_target != noone &&
      _is_a_frente(slot_target) &&
      point_distance(x, y, slot_target.x, slot_target.y) <= pick_radius
    ) {
      if (place_datacore_on_tower(id, slot_target)) {
        // encaixou com sucesso
        return;
      } else {
        // falhou: fallback -> largar no chão
        if (_drop_box()) return;
      }
    } else {
		var element_target = instance_nearest(x, y, obj_array_element);
	    if (
	      element_target != noone &&
	      _is_a_frente(element_target) &&
	      point_distance(x, y, element_target.x, element_target.y) <= pick_radius
	    ) {
			if (place_datacore_on_tower(id, element_target)) {
				// encaixou com sucesso
				return;
		    } else {
				// falhou: fallback -> largar no chão
		        if (_drop_box()) return;
		    }
		} else {
			if (_drop_box()) return;
		}
    }
  }
  // se estiver carregando um cristal (comportamento antigo)
  else if (
    instance_exists(carried_obj) &&
    carried_obj.object_index == obj_crystal
  ) {
    var tnear = instance_nearest(x, y, obj_pointer);
    if (
      tnear != noone &&
      _is_a_frente(tnear) &&
      point_distance(x, y, tnear.x, tnear.y) <= pick_radius
    ) {
      if (place_crystal_on_tower(id, tnear)) {
        return;
      } else {
        if (_drop_box()) return;
      }
    } else {
      if (_drop_box()) return;
    }
  } else {
    // carregando outro tipo (caixa etc) -> usar _drop_box
    if (_drop_box()) return;
  }
}






