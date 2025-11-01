//// State
tablet_open = false;           // whether overlay is visible
current_tab = 0;               // 0..n-1 index of selected tab
mode = "tabs";               // "tabs" or "content"
content_cursor = 0;            // index inside content when in content mode

// Input cooldown to avoid ultra-fast repeats
input_cooldown = 0;
input_cooldown_max = 8; // frames

// Visual configuration
label_font = fnt_secondary_18;
label_color = c_white;
new_concept_color = #488BD4;
bg_color = make_color_rgb(18,20,24);
panel_color = make_color_rgb(28,34,40);
tab_active_color = make_color_rgb(64,200,255);
tab_inactive_color = make_color_rgb(120,130,140);


animation_progress = 0;
is_visible = true;
animation_speed = 0.1;

conceptual_scroll_top = 0;
items_visiveis_na_lista = 1;

objectives_popup_shown = false;

global.objectives_popup_shown_by_room = {};


scribble_font_set_default("fnt_secondary_18");
//scribble_c
scribble_element = scribble("...");       // Irá guardar o objeto de texto do Scribble
current_text_cache = "";        // Irá guardar a string atual para comparação


// Tabs (order matters)
tabs = ["Conceitual", "Objetivos"];

// Placeholder content arrays for each tab (simple strings). Replace these with your real content later
//content_conceitual = [];
content_objetivos = [
	"Ligar A -> G -> J -> N -> T",
	"Evitar sobrecarga das torres",
	"Retornar ao hub e completar relatório"
];
content_opcoes = [
	"Salvar jogo (slot 1)",
	"Carregar jogo",
	"Sair para lobby"
];

// Pause flag used by game objects; the actual objects should check this flag in their Step
if (!variable_global_exists("is_paused")) global.is_paused = false;
	
	

// === CONCEITUAL ===
// lista de itens (cada item tem title + pages array)
// exemplo simples (substitua os textos pelas suas entradas)
concepts_init();
conceptual_items = concept_build_list_for_tablet();

// estado específico da aba Conceitual
conceptual_mode = "list"; // "list" ou "read"
conceptual_page = 0;      // página atual quando estiver lendo
	
// === OBJECTIVES BY ROOM ===
// Estrutura: { label, flag }
// label: texto exibido na aba de objetivos
// flag: nome da variável global (string) que indica se o objetivo foi concluído (true/false)
// Use structs indexadas por nome da sala: objectives_by_room[$ "room_name"] = [ {label, flag}, ... ]

// Create do obj_tablet (ou script init)
objectives_by_day = {};

objectives_by_day = objectives_data();


function tablet_get_objectives_for_day(day_id) {
    var out = [];
    if (!variable_struct_exists(objectives_by_day, day_id)) return out;
    var arr = objectives_by_day[$ day_id];
    for (var i = 0; i < array_length(arr); ++i) {
        var it = arr[i];
        var show = false;
        if (is_bool(it.visible)) show = it.visible;
        else if (is_callable(it.visible)) {
            // chamamos a função defensivamente
            var ok = false;
            try {
                ok = it.visible();
            } catch (e) {
                ok = false;
            }
            show = ok;
        } else {
            show = true;
        }
        if (show) array_push(out, it);
    }
    return out;
}

function tablet_get_objectives_for_room() {
    var out = [];
	rm_name = room_get_name(room);
    if (!variable_struct_exists(objectives_by_day, rm_name)) return out;
    var arr = objectives_by_day[$ rm_name];
    for (var i = 0; i < array_length(arr); ++i) {
        var it = arr[i];
        var show = false;
        if (is_bool(it.visible)) show = it.visible;
        else if (is_callable(it.visible)) {
            // chamamos a função defensivamente
            var ok = false;
            try {
                ok = it.visible();
            } catch (e) {
                ok = false;
            }
            show = ok;
        } else {
            show = true;
        }
        if (show) array_push(out, it);
    }
    return out;
}

function tablet_is_objective_complete(flag) {
    if (flag == "" || is_undefined(flag)) return false;
    if (!variable_global_exists(flag)) return false;
    return (variable_global_get(flag) == true);
}

function objective_set_visible(day_key, obj_id, new_visible) {
    if (!variable_struct_exists(objectives_by_day, day_key)) return false;

    var arr = objectives_by_day[$ day_key];
    if (!is_array(arr)) return false;

    // procurar pelo id
    for (var i = 0; i < array_length(arr); i++) {
        var obj = arr[i];
        if (is_struct(obj) && variable_struct_exists(obj, "id") && obj.id == obj_id) {
            obj.visible = new_visible; // pode ser bool ou função
            arr[i] = obj; // opcional, reforça escrita no array
            objectives_by_day[$ day_key] = arr; // salva de volta
            return true; // sucesso
        }
    }
    return false; // não encontrado
}


// === OPTIONS ITEMS ===
// Cada item: { text, name, use_id, action }
// action é uma function() { ... } ou function(arg) { ... }
// A ação deve ser defensiva (verificar existência de managers, etc.)
options_items = [
    //{
    //    text: "Salvar",
    //    name: "save",
    //    use_id: false,
    //    action: function() { 
	//				var rn = room_get_name(room);
	//				with (obj_save_manager) {
	//					var room_rec = save_room_state_simple(rn); // retorna struct
	//					if (!variable_struct_exists(save_state,"rooms")) save_state.rooms = {};
	//					save_state.rooms[$ rn] = room_rec;
	//					save_state.player = { x: obj_player.x, y: obj_player.y, room_index: room, room_name: room_get_name(room) };
	//					save_slot(1);
	//					show_popup("Jogo salvo no slot 1");
	//				}
	//			} 
    //},
    //{
    //    text: "Carregar",
    //    name: "load",
    //    use_id: false,
    //    action: function() { 
	//				on_close_tablet();
	//				with (global.save_manager) {
	//					load_slot(1);
	//				}
	//				tablet_open = false;
	//				global.is_paused = tablet_open;
	//				global.ui_blocked = false
	//				show_popup("Jogo carregado do slot 1");
	//			} 
    //},
    {
        text: "✖ Sair",
        name: "back",
        use_id: true,
        action: function(_id) { 
					on_close_tablet();
					with (obj_player) {
					    instance_destroy();
					}
					room_goto(rm_main_menu); 	
				} 
    }
];


// === ÚTEIS PARA OBJ_TABLET ===
function on_close_tablet() {
	with(obj_tablet) {
		tablet_open = false;
		global.is_paused = tablet_open;
		input_cooldown = input_cooldown_max;
		conceptual_mode = "list";
		animation_progress = 0;
	}
}



// Just to centralize contents for easier indexing later
contents = [conceptual_items, content_objetivos];