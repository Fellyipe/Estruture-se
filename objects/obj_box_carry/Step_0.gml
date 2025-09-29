// Se está sendo carregada, a caixa só atualiza posição conforme o player
if (carried_by != noone && instance_exists(carried_by)) {
    // a side (direção) a ser usada foi guardada no player (carry_side)
    var side = carried_by.carry_side;
    var px = carried_by.x;
    var py = carried_by.y;
    var off = carry_offset;

    switch(side) {
        case RIGHT:
            x = px + off;
            y = py;
            break;
        case LEFT:
            x = px - off;
            y = py;
            break;
        case UP:
            x = px;
            y = py - off;
            break;
        case DOWN:
            x = px;
            y = py + off;
            break;
        default:
            // fallback
            x = px + off;
            y = py;
    }
    
	// opcional: manter depth ou animações específicas enquanto carregada
    depth = carried_by.depth - 1;
    exit; // não processar lógica física
}

// Se não está sendo carregada, pode implementar física simples (opcional)
// Ex.: pequenas correções de posição, gravidade, fricção, etc.
// Por ora, nada especial.
