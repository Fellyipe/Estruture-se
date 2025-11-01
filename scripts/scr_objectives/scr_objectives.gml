/// Retorna struct com objetivos organizados por day_id

///REPLICA A MESMA COISA DE UNLOCK_CONCEPT()


function objectives_data() {
    var d = {};

    d[$ "rm_puzzle_1_1"] = [
	    { id: "p1_1_main", label: "Configurar ponteiros: A -> B", flag: "puzzle_1_1_completed", visible: true },
	];

	d[$ "rm_puzzle_1_2"] = [
	    { id: "p1_2_main", label: "Configurar sequência conforme o painel", flag: "puzzle_1_2_completed", visible: true },
	];

	d[$ "rm_puzzle_1_3"] = [
	    { id: "p1_3_barrier", label: "Ativar a barreira de energia", flag: "puzzle_1_3_1_completed", visible: true },
	    { id: "p1_3_main",    label: "Configurar sequência conforme o painel", flag: "puzzle_1_3_2_completed", visible: true },
	];

	d[$ "rm_puzzle_2_1"] = [
	    { id: "p2_1_main", label: "Encaixar Datacores nos Data-Slots (conforme o painel)", flag: "puzzle_2_1_completed", visible: true },
	];

	d[$ "rm_puzzle_2_2"] = [
	    { id: "p2_2_main", label: "Organizar a lista encadeada conforme o painel", flag: "puzzle_2_2_completed", visible: true },
	];

	d[$ "rm_puzzle_2_3"] = [
	    { id: "p2_3_main", label: "Montar a primeira parte da lista e apontar para o nó Z", flag: "puzzle_2_3_1_completed", visible: true },
	    { id: "p2_3_last", label: "Configurar o nó final da lista", flag: "puzzle_2_3_2_completed", visible: true },
	];

	d[$ "rm_puzzle_2_4"] = [
	    { id: "p2_3_main", label: "Montar a primeira parte da lista e apontar para o nó Z", flag: "puzzle_2_3_1_completed", visible: true },
	    { id: "p2_3_last", label: "Configurar o nó final da lista", flag: "puzzle_2_3_2_completed", visible: true },
	];

	d[$ "rm_puzzle_3_1"] = [
	    { id: "p3_1_main", label: "Copiar a sequência da lista para o vetor", flag: "puzzle_3_1_completed", visible: true },
	];

	d[$ "rm_puzzle_3_2"] = [
	    { id: "p3_2_main1", label: "Remover elemento da primeira lista (conforme o painel)", flag: "puzzle_3_2_1_completed", visible: true },
	    { id: "p3_2_main2", label: "Remover elemento do primeiro vetor (conforme o painel)", flag: "puzzle_3_2_2_completed", visible: true },
	    { id: "p3_2_main3", label: "Inserir elemento na segunda lista (conforme o painel)", flag: "puzzle_3_2_3_completed", visible: true },
	    { id: "p3_2_main4", label: "Inserir elemento no segundo vetor (conforme o painel)", flag: "puzzle_3_2_4_completed", visible: true },
	];

	d[$ "rm_puzzle_3_3"] = [
	    { id: "p3_3_main", label: "Observar leitura: Vetor vs. Lista", flag: "puzzle_3_3_completed", visible: true },
	];
	
    return d;
}

// <!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>

