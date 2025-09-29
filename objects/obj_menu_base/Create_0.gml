menu_label = "MENU";

menu_items = [
    { text: "Item1",  action: function() { show_debug_message("Ação1"); } },
    { text: "Item2",  action: function() { show_debug_message("Ação2"); } },
];

menu_actions_escape = [
    function() { show_debug_message("Ação Esc"); }
];

selected_index = 0;
