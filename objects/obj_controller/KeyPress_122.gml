// alterna entre fullscreen e janela
if (window_get_fullscreen()) {
    window_set_fullscreen(false); // volta para janela
} else {
    window_set_fullscreen(true); // entra em fullscreen
}
