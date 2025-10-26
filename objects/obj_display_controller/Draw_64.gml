// Black background (automatic bars)
draw_clear(c_black);

// Draw app surface if valid
var surf = application_surface;
if (surface_exists(surf)) {
    // Integer-stretched draw: No distortion at perfect multiples
    draw_surface_ext(surf, global.bar_x, global.bar_y, global.scale, global.scale, 0, c_white, 1);
    // Uses ext for precise scaling; draw_surface_stretched() alternative if needed
}

if (global.scale == 1) {  // Fallback for tiny screens
    if (surface_exists(surf)) {
        draw_surface(surf, global.bar_x, global.bar_y);
    }
}
