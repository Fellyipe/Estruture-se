function box_push(box_id, ix, iy, strength) {
	// aplica impulso proporcional à força / massa
	if (instance_exists(box_id)) {
	    var object_type = box_id.object_index;
		if (object_type != obj_box) return;
		
		with (box_id) {
		    // impulso: soma à velocidade atual
		    vx += ix * (strength / mass);
		    vy += iy * (strength / mass);
		    // clamp
		    var mag = point_distance(0,0,vx,vy);
		    if (mag > max_speed) {
		        vx = vx * (max_speed / mag);
		        vy = vy * (max_speed / mag);
		    }
		}
	}
}




/// Retorna (struct) {x:..., y:...} posição onde a caixa ficaria para um dado player_pos e side
function get_attach_pos(_px, _py, _side, _offset) {
    var _out = {x:_px, y:_py};
    switch(_side) {
        case RIGHT: _out.x = _px + _offset; _out.y = _py; break;
        case LEFT:  _out.x = _px - _offset; _out.y = _py; break;
        case UP:    _out.x = _px; _out.y = _py - _offset; break;
        case DOWN:  _out.x = _px; _out.y = _py + _offset; break;
        default:    _out.x = _px + _offset; _out.y = _py;
    }
    return _out;
}



/// Retorna true se a instância 'inst', posicionada com centro em (tx,ty),
/// colidiria com obj_wall ou com outra obj_box_carry (exclui a própria inst).
/// Uso: var blocked = scr_would_collide_at(carrying, attach.x, attach.y);
function would_collide_at(inst, tx, ty, ignore_tables=false) {

	// segurança: se inst inválida, consideramos bloqueado (ou escolha false se preferir)
	if (!instance_exists(inst)) return true;

	// Obter dimensões aproximadas pela sprite atual (centro-based)
	var _spr = inst.sprite_index;
	var _w = 0;
	var _h = 0;
	if (_spr != noone) {
	    // largura e altura do sprite (em pixels), respeitando escala da instância
	    _w = sprite_get_width(_spr)  * inst.image_xscale;
	    _h = sprite_get_height(_spr) * inst.image_yscale;
	} else {
	    // fallback genérico
	    _w = 32; _h = 32;
	}

	// calcular retângulo onde a inst estaria (ajuste se sua origem não for centro)
	var left   = tx - _w*0.5;
	var top    = ty - _h*0.5;
	var right  = tx + _w*0.5;
	var bottom = ty + _h*0.5;

	// --- 1) checar paredes/solidos (obj_wall), mas tratar obj_table se necessário ---
    var found_wall = collision_rectangle(left, top, right, bottom, obj_wall, true, true);
    if (found_wall != noone) {
        if (ignore_tables) {
            // se a inst encontrada for (ou herdar) de obj_table, IGNORAR esta colisão
            var oi = found_wall.object_index;
            var is_table = false;
            // percorre a cadeia de parents para detectar herança
            if (oi == obj_table) is_table = true;
            if (!is_table) return true; // colisão com wall que NÃO é table -> bloqueado
            // se is_table==true -> ignora e continua checagens abaixo
        } else {
            return true; // colisão com wall e não estamos ignorando mesas -> bloqueado
        }
    }

	var found_crystal = collision_rectangle(left, top, right, bottom, obj_crystal, true, true);
	if (found_crystal != noone && found_crystal != inst) return true;

	var found_datacore = collision_rectangle(left, top, right, bottom, obj_datacore, true, true);
	if (found_datacore != noone && found_datacore != inst) return true;

	var found_static_solid = collision_rectangle(left, top, right, bottom, obj_static_solid, true, true);
	if (found_static_solid != noone && found_static_solid != inst) return true;

	// nada encontrado — não está bloqueado
	return false;
}



