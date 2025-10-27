global.pause_count = 0;
global.is_paused = false;
global.ui_blocked = false;
global.cur_day = "day_00";

global.fnt_poster_24 = font_add("Daydream DEMO.otf", 24, false, false, 32, 128);



//if (display_aa > 12)
//{
//    display_reset(8, true);
//}
//display_reset(0, true);


var _monitor_w = display_get_width();  // Largura do monitor
var _janela_w = window_get_width();    // Largura da janela do jogo

var _pos_x = (_monitor_w - _janela_w) / 2; // Calcula o X para centralizar
var _pos_y = 0;                            // Y = 0 é o topo do monitor

window_set_position(_pos_x, _pos_y);

//cursor_sprite = spr_datacore;
//window_set_cursor(cr_none);