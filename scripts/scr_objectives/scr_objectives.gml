/// Retorna struct com objetivos organizados por day_id
function objectives_data() {
    var d = {};

    d[$ "day_02_puzzle"] = [
        { id: "p2_1_main",    label: "Ligar A → G → J → N → T", flag: "puzzle_2_1_completed", visible: true },
        { id: "p2_1_no_over", label: "Evitar sobrecarga das torres", flag: "puzzle_2_2_completed", visible: true },
        { id: "p2_1_report",  label: "Voltar ao hub e completar relatório", flag: "puzzle_2_3_2_completed", visible: false }
    ];

    d[$ "day_03_puzzle"] = [
        { id: "p3_1_main",    label: "Replicar sequência de datacores no array", flag: "puzzle_3_1_completed", visible: true },
        { id: "p3_2_1", label: "Trocar datacore no meio da lista", flag: "puzzle_3_2_1_completed", visible: true },
        { id: "p3_2_2", label: "Trocar datacore no meio do array", flag: "puzzle_3_2_2_completed", visible: true },
        //{ id: "p3_1_report",  label: "Voltar ao hub e completar relatório", flag: "puzzle_2_3_2_completed", visible: false }
    ];

    // adicione outros day_id aqui...
    // d[$ "day_03_puzzle"] = [ ... ];

    return d;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

