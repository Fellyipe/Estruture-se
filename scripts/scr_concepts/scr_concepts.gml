function concepts_data() {
    var d = {};

    d[$ "concept.pointers"] = {
        title: "Ponteiros",
        pages: [
            "Ponteiros (Cables) apontam uma Tower para outra. Cada pointer guarda um endereço.",
            "Coloque um cristal numa Tower e edite o endereço (R) para apontar outro nó.",
            "Uma Tower só transmite se tiver cristal e receber energia de outra Tower (ou for head)."
        ],
        meta: { days: ["day_01"], rooms: ["rm_puzzle_2_1"], tags: ["basic"] }
    };

    d[$ "concept.nodes"] = {
        title: "Nós e Data-cores",
        pages: [
            "Um Node é uma Tower + Data-slot. O Data-core é o payload (valor) armazenado no slot.",
            "Coloque um Data-core no slot para definir o valor do node; ao mover o core, o valor muda."
        ],
        meta: { days: ["day_01"], rooms: ["rm_puzzle_2_1","rm_puzzle_2_2"], tags: ["basic"] }
    };

    d[$ "concept.arrays"] = {
        title: "Arrays",
        pages: [
			"Um Array é uma sequência de torres alinhadas, cada uma guardando um valor em uma posição fixa (índice).",
			"Ao contrário das listas, os elementos não usam ponteiros - ficam lado a lado. Isso facilita a leitura por posição, mas dificulta inserir ou remover valores no meio."
        ],
        meta: { days: ["day_03"], rooms: ["rm_puzzle_3_1"], tags: ["basic"] }
    };
 
    d[$ "concept.arrays2"] = {
        title: "Inserção e Remoção",
        pages: [
            "Inserir e remover elementos no fim de uma estrutura de dados é fácil, mas, como fazemos para fazer esse inserção ou remoção no meio da estrutura?",
            "Blá blá blá."
        ],
        meta: { days: ["day_01"], rooms: ["rm_puzzle_2_1","rm_puzzle_2_2"], tags: ["basic"] }
    };

    // ... adicionar mais conceitos ...

    return d;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function concepts_init() {
    global.concepts_data = [];
	global.concepts_data = concepts_data();
    global.unlocked_concepts = [];
    global.unlocked_concepts = variable_clone(obj_save_manager.save_state.concepts_unlocked);
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function concept_get(concept_id) {
    var d = concepts_data();
    if (d[$ concept_id] == undefined) {
        return noone;
    } else {
        return d[$ concept_id];
    }
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// concept_unlock(id) -> true if newly unlocked, false if was already unlocked
function concept_unlock(concept_id) {
    if (!is_string(concept_id) || string_length(concept_id) == 0) return false;
    if (!variable_global_exists("unlocked_concepts")) global.unlocked_concepts = [];
    // check exists in data (defensive)
    var c = concept_get(concept_id);
    if (c == noone) {
        show_debug_message("scr_concept_unlock: id not found: " + string(concept_id));
        return false;
    }
    // already unlocked?
    for (var i = 0; i < array_length(global.unlocked_concepts); ++i) {
        if (global.unlocked_concepts[i] == concept_id) return false;
    }
    array_push(global.unlocked_concepts, concept_id);
    // optional: immediate feedback to player
    show_popup("Novo conceito desbloqueado: " + string(c.title), 2);
	show_concept_notify();
	obj_tablet.conceptual_items = concept_build_list_for_tablet();
    return true;
}


// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

function concept_is_unlocked(concept_id) {
    if (!variable_global_exists("unlocked_concepts")) return false;
    for (var i = 0; i < array_length(global.unlocked_concepts); ++i) {
        if (global.unlocked_concepts[i] == concept_id) return true;
    }
    return false;
}


// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

/// concept_build_list_for_tablet() -> returns array of structs {id, title}
function concept_build_list_for_tablet() {
    var out = [];
    if (!variable_global_exists("unlocked_concepts")) return out;
    for (var i = 0; i < array_length(global.unlocked_concepts); ++i) {
        var concept_id = global.unlocked_concepts[i];
        var c = concept_get(concept_id);
        if (c != noone) {
            array_push(out, { id: concept_id, title: c.title });
        }
    }
    return out;
}

