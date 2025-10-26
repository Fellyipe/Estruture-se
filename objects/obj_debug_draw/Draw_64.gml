/// @description Desenha informações de depuração de resolução na tela.

// Pega todas as dimensões relevantes
var display_w = display_get_width();
var display_h = display_get_height();
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var view_w = view_get_wport(0);
var view_h = view_get_hport(0);
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

// Configura o desenho
draw_set_font(fnt_menu); // Use uma fonte que você tenha
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var text_x = 10;
var text_y = 10;
var line_height = 20;

// Desenha as informações
draw_set_color(c_black);
draw_rectangle(text_x - 5, text_y - 5, text_x + 400, text_y + 150, false); // Fundo para o texto

draw_set_color(c_white);
draw_text(text_x, text_y, "Monitor: " + string(display_w) + "x" + string(display_h));
text_y += line_height;
draw_text(text_x, text_y, "GUI Layer: " + string(gui_w) + "x" + string(gui_h) + " (Deve ser 640x360)");
text_y += line_height;
draw_text(text_x, text_y, "Viewport na Tela: " + string(view_w) + "x" + string(view_h) + " (Deve ser 1280x720)");
text_y += line_height;
draw_text(text_x, text_y, "Câmera no Jogo: " + string(cam_w) + "x" + string(cam_h) + " (Deve ser 640x360)");

// Desenha uma borda VERDE ao redor da área da GUI.
// Se esta borda estiver distorcida ou não preencher a área do jogo, encontramos o problema.
draw_set_color(c_lime);
draw_rectangle(0, 0, gui_w - 1, gui_h - 1, true); // O "-1" é para manter dentro dos limites