function concepts_data() {
    var d = {};
	
	d[$ "intro_lore"] = {
        title: "Introdução",
		pages: [
	        "Há poucos anos, campos cristalinos foram descobertos em um vale remoto - fragmentos de um mineral que reagem à eletricidade de formas que a ciência ainda tenta compreender.", 

			"Esses cristais, ao entrarem em contato com correntes elétricas, são capazes de canalizar grandes quantidades de energia, transportando-a através do espaço quase como se a conduzissem pelo ar. São fontes limpas, poderosas e, ao mesmo tempo, imprevisíveis.",

			"A AetherGrid nasceu dessa descoberta. Um grupo de engenheiros e pesquisadores percebeu que esses cristais poderiam revolucionar a infraestrutura energética. Com o tempo, descobriram algo ainda mais surpreendente: sob certas condições, eles também podiam preservar e retransmitir padrões de informação.",

			"Foi assim que surgiram os Datacores - versões modificadas dos cristais, ajustadas para armazenar e processar dados com alta estabilidade. Eles se tornaram a base de uma nova geração de sistemas de comunicação e controle energético.",

			"Hoje, a AetherGrid mantém e opera redes inteiras baseadas nesses cristais. Mas, por mais avançada que seja a tecnologia, ela ainda é delicada. Um pequeno erro de configuração pode gerar instabilidades perigosas.",
			
			"Por isso, cada unidade precisa de manutenção constante - e de pessoas qualificadas para lidar com elas. Técnicos treinados, com reflexos rápidos e raciocínio preciso, são enviados para dentro das unidades de manutenção... e é aí que entra [#fffa11]você[/colour]!"
		]
	};
	
	d[$ "welcome_day1"] = {
        title: "Boas-vindas!",
		pages: [
	        "Bem-vindo à [#00567F]Aether[#207F19]Grid[/colour]. Você foi designado para o setor de manutenção de sistemas [c_cristal]cristalinos[/colour] - o núcleo que mantém a rede funcionando. Seu trabalho é garantir que a energia e os dados circulem corretamente entre as torres e estruturas conectadas à rede.",
			
			"Seu [c_forte_amarelo]tablet[/colour] é a principal ferramenta de apoio. É nele que você encontrará instruções, objetivos e explicações sobre o funcionamento dos equipamentos. Para acessá-lo, pressione [c_tecla]Tab[/colour]. Novos módulos serão adicionados ao [c_forte_amarelo]tablet[/colour] conforme você descobre novos componentes durante o trabalho.",
			
			"A cada dia de trabalho, você será encaminhado para o setor designado. Lá, deverá inspecionar e restaurar o funcionamento das salas indicadas. Após concluir todos os objetivos, o sistema abrirá o acesso de volta ao [c_sala]lobby[/colour].",
			
			"Quando retornar ao [c_sala]lobby[/colour], dirija-se ao setor de [c_sala]Recursos Humanos[/colour] para registrar o encerramento do turno. Essa etapa confirma o fim das atividades e encerra o dia.",
			
			"Vá até o [c_forte_amarelo]elevador[/colour], siga as orientações do [c_forte_amarelo]tablet[/colour] e mantenha o sistema estável. Boa sorte no seu primeiro dia!"

		]
	};
	
	d[$ "day1_pointer_crystal"] = {
        title: "Torre Ponteiro e Cristais",
		pages: [
	        "Cada torre que você vê é uma [c_torres]Torre Ponteiro[/colour] [spr_pointer, 0]. Quando energizada, ela pode direcionar o fluxo de energia para outra torre - como se estivesse apontando para ela.",

			"Para isso, cada torre precisa de um [c_cristal]cristal[/colour] [spr_crystal]. Os [c_cristal]cristais[/colour] conduzem a energia entre as torres. Basta se aproximar de um [c_cristal]cristal[/colour] pressionar [c_tecla]E[/colour] para pegar. Quando estiver com um [c_cristal]cristal[/colour] em mãos, aproxime-se de uma [c_torres]torre ponteiro[/colour] e pressione [c_tecla]E[/colour] novamente para encaixá-lo. Se você quiser remover um [c_cristal]cristal[/colour] de uma torre, pressione [c_tecla]E[/colour] mais uma vez - desde que suas mãos estejam livres.",

			"Ao se aproximar de uma [c_torres]torre ponteiro[/colour], pressione [c_tecla]Q[/colour] para abrir sua interface de edição. Nela, você poderá definir o endereço de destino - a torre para onde este [c_torres]ponteiro[/colour] enviará energia. Os endereços seguem o formato hexadecimal de quatro dígitos (de 0 a F). Por exemplo: [#928FB8]0x12ab[/colour], onde o [#928FB8]0x[/colour] indica que se trata de uma notação hexadecimal.",

			"Quando o endereço aponta corretamente para outra torre existente, e essa torre também possui um [c_cristal]cristal[/colour], a energia flui, e a torre receptora acende.",
		]
	};

	d[$ "day1_room1_instructions"] = {
        title: "Instruções - Ponteiros",
		pages: [
			"Esta é sua primeira tarefa prática. Seu objetivo é restaurar a rota de energia entre as [c_torres]torres ponteiro[/colour], seguindo o esquema exibido no [#928FB8]painel[/colour] da direita [spr_poster].",

			"Abaixo de cada torre há uma [#928FB8]placa identificadora[/colour] [spr_letters, 33] e no [#928FB8]painel[/colour] da direita [spr_poster] você encontrará o mapa de ligação entre elas. Para resolver, encaixe os [c_cristal]cristais[/colour] nas torres indicadas e edite os endereços conforme o mapa.",

			"O [#928FB8]painel[/colour] da esquerda mostra a correspondência entre cada torre e seu endereço hexadecimal (exemplo: &A = 0x1111). Use essa referência para configurar corretamente os [c_torres]ponteiros[/colour]. Para abrir um [#928FB8]painel[/colour], aproxime-se de um deles e aperte [c_tecla]Q[/colour]",

			"Quando todos os endereços estiverem certos e a rota de energia completa, as torres estarão iluminadas, e a porta da sala será aberta. Caso algo não funcione, revise as ligações e corrija o fluxo.",

			"Por fim, note que a torre com um [#928FB8]círculo branco[/colour] [spr_pointer_head] na base é a torre [#928FB8]Head[/colour] - a origem da corrente. É ela quem inicia o fluxo de energia por toda a cadeia de [c_torres]ponteiros[/colour]."
		]
	};



	d[$ "day1_pointer_concept"] = {
        title: "O que é um Ponteiro",
		pages: [
			"No mundo real, um [c_torres]ponteiro[/colour] é uma variável que armazena um endereço de memória - ou seja, ele não guarda um valor diretamente, mas indica onde esse valor está. Um [c_torres]ponteiro[/colour] pode também apontar para outro [c_torres]ponteiro[/colour], formando cadeias de endereços. À primeira vista, isso pode não ter um propósito prático, mas mais adiante você verá como essa ideia se torna uma ferramenta poderosa."
		]
	};


	d[$ "day1_room3_overview"] = {
		title: "Barreira de energia",
		pages: [
			"Nesta sala há um [c_torres]poste[/colour] [spr_lightning_bulb, 0] que mantém ativo um campo elétrico, funcionando como uma barreira de segurança que impede a passagem. Uma das [c_torres]torres ponteiro[/colour] está diretamente ligada ao poste, e enquanto essa torre estiver energizada, o campo permanece ativo.",

			"Seu objetivo é temporariamente desativar a barreira, atravessar para a área bloqueada, reorganizar as torres nesse setor e, ao final, reativar a barreira.",

			"Para desativar a barreira de energia, interrompa o fluxo que chega à torre do poste. Uma forma simples de fazer isso é editar o endereço da torre que aponta para a torre ligada ao poste, configurando-o como nulo (null), assim o [c_torres]ponteiro[/colour] deixa de apontar para qualquer torre.",		]
	};

	d[$ "day1_ending"] = {
		title: "Fim do dia",
		pages: [
			"Parabéns! você concluiu todos os objetivos deste dia. Volte para o [c_sala]lobby[/colour] e dirija-se à sala do [c_sala]RH[/colour]",
		]
	};


	d[$ "day2_datacore_node_concept"] = {
		title: "Datacore, Data-Slot e Nó",
		pages: [
			"Os [c_datacore]Datacores[/colour] [spr_datacore, 5] são a evolução controlada dos [c_cristal]cristais[/colour]: elementos sintetizados para armazenar, processar e retransmitir informação com alta estabilidade e baixa latência. Pense neles como pequenos núcleos inteligentes - eles podem guardar padrões, executar rotinas simples ou manter estados que serão lidos por outros módulos.",
			
			"O [c_torres]Data-Slot[/colour] [spr_data_slot, 0] é um tipo de receptáculo, projetado para acomodar um [c_datacore]datacore[/colour] com segurança. Ele segura o núcleo no lugar, mantendo a conexão elétrica necessária para que o [c_datacore]datacore[/colour] cumpra sua função. Assim, o slot mantém o [c_datacore]datacore[/colour] alinhado ao sistema e facilita a manutenção.",
			
			"Um [c_coisa]Nó[/colour] é a união prática entre um [c_torres]data-slot[/colour] e uma [c_torres]torre ponteiro[/colour]. Pense no nó como uma estação: o slot aloja o [c_datacore]datacore[/colour]; o [c_torres]ponteiro[/colour] faz a ligação com o próximo ponto da cadeia. Dentro dessa estação, a [c_torres]torre ponteiro[/colour] é o agente direcional: é ela quem transmite o pulso, levando energia e também o sinal que carrega a informação do [c_datacore]datacore[/colour] adiante.",
			
			"Ou seja: os [c_torres]data-slots[/colour] armazenam/contêm os dados; as [c_torres]torres ponteiros[/colour] apontam e transmitem. Juntos, eles permitem que tanto energia quanto informação sigam o roteiro definido.",
			
			"Quando vários nós são conectados, formam uma [#]lista encadeada[/colour]: uma sequência de estações onde cada nó conhece o endereço do próximo. A ordem importa - cada [c_datacore]datacore[/colour] pode cumprir um papel distinto dentro do processo: alguns apenas armazenam dados, outros executam módulos de processamento, e alguns realizam verificações ou controle. Independentemente da função de cada um, é a sequência correta que garante o fluxo lógico e contínuo de processamento de informações.",
			
			"Para pegar um [c_datacore]datacore[/colour], aproxime-se dele e pressione [c_tecla]E[/colour]. Para encaixá-lo em um [c_torres]data-slot[/colour], aproxime-se do slot vazio e pressione [c_tecla]E[/colour] novamente. Para remover um [c_datacore]datacore[/colour], basta repetir o mesmo procedimento, desde que você não esteja segurando outro objeto."
		]
	};

	d[$ "day2_room1_instructions"] = {
		title: "Instruções - Nós",
		pages: [
			"Agora você lidará com os [c_datacore]datacores[/colour] e [c_torres]data-slots[/colour]. Os [c_torres]ponteiros[/colour] já estão configurados, então seu trabalho é apenas posicionar corretamente os [c_datacore]datacores[/colour] nos slots.",
			
			"Para isso, encaixe cada [c_datacore]datacore[/colour] no [c_torres]data-slot[/colour] correspondente, seguindo o esquema exibido no [#928FB8]painel[/colour] da parede. "
		]
	};

	d[$ "day2_node_concept"] = {
		title: "Conceito de Nó",
		pages: [
			"No mundo real, um [#78D7FF]nó[/colour] é uma unidade fundamental na estruturação de dados. Cada nó armazena um valor e uma referência (ou endereço) para outro nó. Isso permite criar cadeias de elementos conectados, onde cada um sabe apenas para onde seguir. ",
			"Em um nó, um [c_torres]ponteiro[/colour] pode estar vazio (null), indicando que o nó não tem sucessor. Esse é o fim natural de uma lista encadeada. ",
			"Esse conceito simples é a base para diversas estruturas de dados, como [#78D7FF]listas encadeadas[/colour], [#78D7FF]árvores[/colour] e [#78D7FF]grafos[/colour]. Em todas elas, os nós trabalham juntos para organizar e relacionar informações de forma flexível e dinâmica. "
		]
	};

	d[$ "day2_room3_overview"] = {
    title: "Lista Distribuída",
    pages: [
        "Esta área conecta duas salas em uma única sequência: a sala principal concentra a maior parte dos nós; a sala adjacente abriga o nó final.",
        "A sequência atravessa o espaço entre as salas - trate-a como um único fluxo e configure a lista seguindo o esquema do [#928FB8]painel[/colour]."
    ]
};


	d[$ "day3_array_overview"] = {
		title: "Vetor e Células",
		pages: [
			"Um [c_torres]Vetor[/colour] é uma sequência ordenada de posições chamadas [c_torres]Células[/colour] [spr_array_element, 0]. Visualmente, imagine uma fileira de compartimentos alinhados - cada [c_torres]célula[/colour] pode receber um [c_datacore]datacore[/colour] e manter esse núcleo em um lugar fixo dentro da estrutura.",
			
			"Cada [c_torres]célula[/colour] funciona de maneira semelhante a um [c_torres]data-slot[/colour]: ela segura um [c_datacore]datacore[/colour] e o conecta ao sistema. A diferença principal é que as [c_torres]células[/colour] estão organizadas como um grupo contíguo que forma o Vetor - elas pertencem a uma mesma sequência física e lógica.",
			
			"Para acessar uma [c_torres]célula[/colour], o sistema usa um número chamado índice. O índice indica a posição da [c_torres]célula[colour] dentro do vetor (começando em zero): a [c_torres]célula[/colour] de índice 0 é a primeira, índice 1 a segunda, e assim por diante. Quando o sistema precisa ler ou escrever em uma [c_torres]célula[/colour], ele usa esse índice para localizar a posição exata e operar diretamente naquela [c_torres]célula[/colour].",
			
			"Os Vetores servem para mostrar como dados ou núcleos podem ser organizados em espaços contíguos: em vez de 'seguir' um caminho de nó a nó, aqui você coloca o [c_datacore]datacore[/colour] diretamente na [c_torres]célula[/colour] desejada - cada [c_torres]célula[/colour] representa um slot posicional fixo dentro do vetor.",
			
		]
	};

	d[$ "day3_room1_instructions"] = {
		title: "Instruções - Vetor",
		pages: [
			"Nesta sala, você verá uma sequência de [#488BD4]nós[/colour] de uma lista encadeada preenchidos com [c_datacore]datacores[/colour], exibindo a ordem correta. Ao topo da sala há um [c_objeto]Vetor[/colour] de células vazias. ",
			
			"Seu objetivo é copiar a sequência da lista e colocar os [c_datacore]datacores[/colour] nas [c_torres]células[/colour] correspondentes, preenchendo o [c_objeto]Vetor[/colour] na mesma ordem mostrada pelos nós.",
			
			"Aproxime-se de uma [c_torres]célula[/colour] e pressione [c_tecla]E[/colour] para encaixar um [c_datacore]datacore[/colour]. Se quiser remover o [c_datacore]datacore[/colour] de um [c_torres]célula[/colour], pressione [c_tecla]E[/colour] novamente - desde que suas mãos estejam livres.",
		]
	};

	d[$ "day3_array_concept"] = {
		title: "Conceito de Vetor",
		pages: [
			"Em termos técnicos, um [c_objeto]vetor[/colour] (ou array) organiza valores em um espaço contíguo de memória. A posição física de uma elemento pode ser calculada a partir de um endereço-base mais o índice vezes o tamanho do elemento (posição = base + índice * tamanho). Esse mapeamento é o que permite acessar diretamente qualquer elemento pelo seu índice."
		]
	};

	d[$ "day3_room2_concept"] = {
		title: "Inserção e Remoção",
		pages: [
			"Em uma lista encadeada, cada nó aponta para o próximo por meio de um [c_torres]ponteiro[/colour]. Para remover um nó no meio da lista, basta ajustar o [c_torres]ponteiro[/colour] do nó anterior para que ele passe a apontar para o seguinte - assim, o nó removido é simplesmente pulado. Já para inserir um novo nó, é preciso ligar o [c_torres]ponteiro[/colour] do nó anterior ao novo nó, e então conectar o novo nó ao próximo, completando a cadeia novamente.",
			"Em um [c_objeto]Vetor[/colour], as [c_torres]células[/colour] formam um bloco contínuo na memória - não há [c_torres]ponteiros[/colour] que permitam saltar posições. Por isso, quando você remove um elemento do meio, é necessário mover todos os elementos seguintes uma posição para trás, fechando o espaço vazio. Do mesmo modo, ao inserir um elemento no meio, é preciso deslocar os elementos à frente para abrir espaço.",
			"Com poucos elementos, essa diferença pode parecer pequena, mas em estruturas com centenas ou milhares de elementos o custo de mover cada [c_torres]célula[/colour] cresce rapidamente. Por isso, em sistemas reais, a escolha entre uma [#488BD4]Lista Encadeada[/colour] ou um [c_torres]Vetor[/colour] depende das operações que precisam ser feitas com mais frequência.",		
		]
	};
	




	d[$ "day3_room2_instructions"] = {
		title: "Reorganizando Estruturas",
		pages: [
			"Você está diante de dois pares de estruturas: [c_objeto]Listas Encadeadas[/colour] e [c_objeto]Vetores[/colour]. Cada par contém a mesma sequência de [c_datacore]datacores[/colour].",
			"Seu trabalho é reorganizar as estruturas conforme os [#928FB8]painéis[/colour] de referência: no primeiro par, remova um [c_datacore]datacore[/colour] do meio da sequência; no segundo par, insira esse mesmo [c_datacore]datacore[/colour] na posição indicada.",
			"Nas [#488BD4]Listas Encadeadas[/colour], ajuste as ligações dos [c_torres]ponteiros[/colour] para manter a sequência contínua. Nos [c_objeto]vetores[/colour], mova os [c_datacore]datacores[/colour] de modo que não reste nenhum espaço vazio entre as [c_white]células[/colour].",		
		]
	};

	d[$ "day3_room3_concept"] = {
		title: "Leitura: Vetor vs Lista",
		pages: [
			"Aqui você verá como a informação é percorrida dentro de duas estruturas diferentes: o [c_objeto]Vetor[/colour] e a [c_objeto]Lista Encadeada[/colour]. Ambas armazenam dados, mas o caminho até cada valor é bem distinto.",
			"No [c_objeto]Vetor[/colour], cada [c_torres]célula[/colour] ocupa um espaço contíguo na memória. Isso permite que o sistema calcule a posição exata de qualquer elemento a partir de seu índice - sem precisar percorrer o restante da estrutura. É como abrir uma gaveta numerada e pegar o item certo de uma vez.",
			"Já na [c_objeto]Lista Encadeada[/colour], os dados estão distribuídos em diferentes endereços de memória, conectados por [c_torres]ponteiros[/colour]. Cada nó sabe apenas onde está o próximo, então para encontrar um elemento específico, é preciso seguir essa corrente, nó por nó, até alcançá-lo.",
			"Durante a simulação, o painel central exibirá a posição do elemento desejado e alternará entre as duas leituras. No [c_objeto]Vetor[/colour], a [c_torres]célula[/colour] correspondente será iluminada de imediato; na [c_objeto]Lista[/colour], os nós acenderão em sequência até chegar ao valor pedido.",
			"Você não precisa realizar nenhuma ação nesta sala - apenas observe e perceba como cada estrutura lida com o processo de leitura de um valor."
		]
	};
	
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
        show_debug_message("concept_unlock: id not found: " + string(concept_id));
        return false;
    }
    // already unlocked?
    for (var i = 0; i < array_length(global.unlocked_concepts); ++i) {
        if (global.unlocked_concepts[i] == concept_id) return false;
    }
    //array_push(global.unlocked_concepts, concept_id);
    array_insert(global.unlocked_concepts, 0, concept_id);
	
	concept_add_unread(concept_id);
	
	// optional: immediate feedback to player
    //show_popup("Novo conceito desbloqueado: " + string(c.title), 2);
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




/// concept_add_unread(concept_id)
function concept_add_unread(concept_id) {
    if (is_undefined(concept_id) || !is_string(concept_id) || string_length(concept_id) == 0) return false;
    if (!variable_global_exists("unread_concepts")) global.unread_concepts = [];
    // evita duplicatas
    for (var i = 0; i < array_length(global.unread_concepts); ++i) {
        if (global.unread_concepts[i] == concept_id) return false;
    }	
    array_insert(global.unread_concepts, 0, concept_id);
    return true;
}

/// concept_mark_read(concept_id) -> remove da lista de não-lidos (retorna true se removeu)
function concept_mark_read(concept_id) {
    if (!variable_global_exists("unread_concepts")) return false;
    var removed = false;
    // remove todas as ocorrências por segurança
    var i = array_length(global.unread_concepts) - 1;
    while (i >= 0) {
        if (global.unread_concepts[i] == concept_id) {
            array_delete(global.unread_concepts, i, 1);
            removed = true;
        }
        i -= 1;
    }
    return removed;
}

/// concept_is_unread(concept_id) -> true/false
function concept_is_unread(concept_id) {
    if (!variable_global_exists("unread_concepts")) return false;
    for (var i = 0; i < array_length(global.unread_concepts); ++i) {
        if (global.unread_concepts[i] == concept_id) return true;
    }
    return false;
}

