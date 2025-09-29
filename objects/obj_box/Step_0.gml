// 1) aplica friction (damping)
vx *= friction;
vy *= friction;

// 2) se velocidades muito pequenas, zera para evitar micro-movimento
if (abs(vx) < 0.02) vx = 0;
if (abs(vy) < 0.02) vy = 0;

// 3) mover com resolução por eixo (mesma técnica do player)
var dx = vx;
var dy = vy;

// mover em X com loop de 1px (evita tunneling)
if (dx != 0) {
    var step = sign(dx);
    var remaining = abs(dx);
    while (remaining > 0) {
        if (!place_meeting(x + step, y, obj_wall) && !place_meeting(x + step, y, obj_solid) && !place_meeting(x + step, y, obj_static_solid)) {
            x += step;
            remaining -= 1;
        } else {
            // colisão: zera velocidade na direção
            vx = 0;
            break;
        }
    }
}

// mover em Y
if (dy != 0) {
    var step2 = sign(dy);
    var remaining2 = abs(dy);
    while (remaining2 > 0) {
        if (!place_meeting(x, y + step2, obj_wall) && !place_meeting(x, y + step2, obj_solid) && !place_meeting(x + step2, y, obj_static_solid)) {
            y += step2;
            remaining2 -= 1;
        } else {
            vy = 0;
            break;
        }
    }
}
