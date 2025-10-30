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
	        "Bem-vindo à AetherGrid. Você foi designado para o setor de manutenção de sistemas [#fafafa]cristalinos[/colour] - o núcleo que mantém a rede funcionando. Seu trabalho é garantir que a energia e os dados circulem corretamente entre as torres e estruturas conectadas aos [#98E674]datacores[/colour].",
			
			"Seu [#fffa11]tablet[/colour] é a principal ferramenta de apoio. É nele que você encontrará instruções, objetivos e explicações sobre o funcionamento dos equipamentos. Para acessá-lo, pressione [#78D7FF]Tab[/colour]. Novos módulos serão adicionados ao [#fffa11]tablet[/colour] conforme você descobre novos componentes durante o trabalho.",
			
			"A cada dia de trabalho, você será encaminhado para o setor designado. Lá, deverá inspecionar e restaurar o funcionamento das salas indicadas. Após concluir todos os objetivos, o sistema abrirá o acesso de volta ao [#FF9757]lobby[/colour].",
			
			"Quando retornar ao [#FF9757]lobby[/colour], dirija-se ao setor de [#FF9757]Recursos Humanos[/colour] para registrar o encerramento do turno. Essa etapa confirma o fim das atividades e encerra o dia.",
			
			"Vá até o elevador, siga as orientações do [#fffa11]tablet[/colour] e mantenha o sistema estável. Boa sorte no seu primeiro dia!"

		]
	};
	
	d[$ "day1_pointer_crystal"] = {
        title: "Torre Ponteiro e Cristais",
		pages: [
	        "Cada torre que você vê é uma [#488BD4]Torre Ponteiro[/colour][spr_pointer]. Quando energizada, ela pode direcionar o fluxo de energia para outra torre - como se estivesse apontando para ela.",

			"Para isso, cada torre precisa de um [#fafafa]cristal[/colour]. Os [#fafafa]cristais[/colour] conduzem a energia entre as torres. Basta se aproximar de um [#fafafa]cristal[/colour] pressionar [#78D7FF]E[/colour] para pegar. Quando estiver com um [#fafafa]cristal[/colour] em mãos, aproxime-se de uma [#488BD4]torre ponteiro[/colour] e pressione [#78D7FF]E[/colour] novamente para encaixá-lo. Se você quiser remover um [#fafafa]cristal[/colour] de uma torre, pressione [#78D7FF]E[/colour] mais uma vez - desde que suas mãos estejam livres.",

			"Ao se aproximar de uma [#488BD4]torre ponteiro[/colour], pressione [#78D7FF]R[/colour] para abrir sua interface de edição. Nela, você poderá definir o endereço de destino - a torre para onde este [#488BD4]ponteiro[/colour] enviará energia. Os endereços seguem o formato hexadecimal de quatro dígitos (0 a F). Por exemplo: [#928FB8]0x12ab[/colour], onde o [#928FB8]0x[/colour] indica que se trata de uma notação hexadecimal.",

			"Quando o endereço aponta corretamente para outra torre existente, e essa torre também possui um [#fafafa]cristal[/colour], a energia flui, e a torre receptora acende.",
		]
	};
	
	d[$ "day1_room1_instructions"] = {
        title: "Primeiras Instruções",
		pages: [
			"Esta é sua primeira tarefa prática. Seu objetivo é restaurar a rota de energia entre as [#488BD4]torres ponteiro[/colour], seguindo o esquema exibido no [#928FB8]painel[/colour] da direita.",

			"Abaixo de cada torre há uma [#928FB8]placa identificadora[/colour] — A, B, C… — e no [#928FB8]painel[/colour] da direita você encontrará o mapa de ligação entre elas. Para resolver, encaixe os [#fafafa]cristais[/colour] nas torres indicadas e edite os endereços conforme o mapa.",

			"O [#928FB8]painel[/colour] da esquerda mostra a correspondência entre cada torre e seu endereço hexadecimal (exemplo: &A = 0x1111). Use essa referência para configurar corretamente os [#488BD4]ponteiros[/colour].",

			"Quando todos os endereços estiverem certos e a rota de energia completa, as torres estarão iluminadas, e a porta da sala será aberta. Caso algo não funcione, revise as ligações e corrija o fluxo.",

			"Por fim, note que a torre com um [#928FB8]círculo branco[/colour] na base é a torre [#928FB8]Head[/colour] — a origem da corrente. É ela quem inicia o fluxo de energia por toda a cadeia de [#488BD4]ponteiros[/colour]."
		]
	};



	d[$ "day1_pointer_concept"] = {
        title: "Conceito de Ponteiro",
		pages: [
			"No mundo real, um [#488BD4]ponteiro[/colour] é uma variável que armazena um endereço de memória — ou seja, ele não guarda um valor diretamente, mas indica onde esse valor está. Um [#488BD4]ponteiro[/colour] pode também apontar para outro ponteiro, formando cadeias de endereços. À primeira vista, isso pode não ter um propósito prático, mas mais adiante você verá como essa ideia se torna uma ferramenta poderosa."
		]
	};


	d[$ "day1_room3_overview"] = {
		title: "Barreira de energia",
		pages: [
			"Nesta sala há um [#928FB8]poste[/colour] que mantém ativo um [#928FB8]campo elétrico[/colour], funcionando como uma barreira que impede a passagem. Uma das [#488BD4]torres ponteiro[/colour] está diretamente ligada ao poste, e enquanto essa torre estiver energizada, o campo permanece ativo.",

			"Seu objetivo é temporariamente desativar a barreira, atravessar para a área bloqueada, reorganizar as torres nesse setor e, ao final, reativar a barreira.",

			"Para desativar a barreira de energia, interrompa o fluxo que chega à torre do poste. Uma forma simples de fazer isso é editar o endereço da torre que aponta para a torre ligada ao poste, configurando-o como nulo ([#928FB8]null[/colour])."
		]
	};


	d[$ "day2_datacore_node_concept"] = {
		title: "Datacore, Data Slot e Nó",
		pages: [
			"Os Datacores são a evolução controlada dos cristais: elementos sintetizados para armazenar, processar e retransmitir informação com alta estabilidade. Pense neles como pequenos núcleos inteligentes — eles podem guardar padrões, executar rotinas simples ou manter estados que serão lidos por outros módulos.",
			
			"O Data Slot é um tipo de receptáculo, projetado para acomodar um datacore com segurança. Ele segura o núcleo no lugar, mantendo a conexão elétrica necessária para que o Datacore cumpra sua função. Assim, o slot mantém o Datacore alinhado ao sistema e facilita a manutenção.",
			
			"Um [#78D7FF]Nó[/colour] é a união prática entre um [#488BD4]Data Slot[/colour] e uma torre ponteiro. Pense no nó como uma estação: o slot aloja o Datacore; o ponteiro faz a ligação com o próximo ponto da cadeia. Dentro dessa estação, a torre ponteiro é o agente direcional: é ela quem transmite o pulso, levando energia e também o sinal que carrega a informação do Datacore adiante. Ou seja: os data slots armazenam/contêm os dados; os ponteiros apontam e transmitem. Juntos, eles permitem que tanto energia quanto informação sigam o roteiro definido.",
			
			"Quando vários nós são conectados, formam uma [#78D7FF]lista encadeada[/colour]: uma sequência de estações onde cada nó conhece o endereço do próximo. A ordem importa — cada [#fafafa]Datacore[/colour] pode cumprir um papel distinto dentro do processo: alguns apenas armazenam dados, outros executam módulos de processamento, e alguns realizam verificações ou controle. Independentemente da função de cada um, é a sequência correta que garante o fluxo lógico e contínuo de processamento de informações.",
			
			"Para pegar um [#fafafa]datacore[/colour], aproxime-se dele e pressione [#78D7FF]E[/colour]. Para encaixá-lo em um [#488BD4]data slot[/colour], aproxime-se do slot vazio e pressione [#78D7FF]E[/colour] novamente. Para remover um datacore, basta repetir o mesmo procedimento, desde que você não esteja segurando outro objeto."
		]
	};

	d[$ "day2_room1_instructions"] = {
		title: "Organizando Nós",
		pages: [
			"Agora você lidará com os [#fafafa]Datacores[/colour] e [#488BD4]Data Slots[/colour]. Os ponteiros já estão configurados, então seu trabalho é apenas posicionar corretamente os [#fafafa]datacores[/colour] nos slots.",
			
			"Para isso, encaixe cada [#fafafa]Datacore[/colour] no [#488BD4]Data Slot[/colour] correspondente, seguindo o esquema exibido no [#928FB8]painel[/colour] da parede. "
		]
	};

	d[$ "day2_node_concept"] = {
		title: "Conceito de Nó",
		pages: [
			"No mundo real, um [#78D7FF]nó[/colour] é uma unidade fundamental na estruturação de dados. Cada nó armazena um valor e uma referência (ou endereço) para outro nó. Isso permite criar cadeias de elementos conectados, onde cada um sabe apenas para onde seguir. ",
			
			"Esse conceito simples é a base para diversas estruturas de dados, como [#78D7FF]listas encadeadas[/colour], [#78D7FF]árvores[/colour] e [#78D7FF]grafos[/colour]. Em todas elas, os nós trabalham juntos para organizar e relacionar informações de forma flexível e dinâmica. "
		]
	};

	d[$ "day2_room3_overview"] = {
		title: "Listas simultâneas",
		pages: [
			"Esta área é composta por três salas interconectadas, que você pode atravessar livremente. À esquerda e à direita, você encontrará duas listas para serem configuradas.",
			"O objetivo principal é que o [#78D7FF]nó central[/colour], localizado entre as duas listas, seja o último elemento de ambas. Para isso, cada lista deve estar corretamente configurada, pois a ativação do nó central depende da combinação de ambas."
		]
	};

	d[$ "day3_array_overview"] = {
		title: "Vetor e Células",
		pages: [
			"Um [#488BD4]Vetor[/colour] é uma sequência ordenada de posições chamadas [#488BD4]Células[/colour]. Visualmente, imagine uma fileira de compartimentos alinhados — cada célula pode receber um Datacore e manter esse núcleo em um lugar fixo dentro da estrutura.",
			
			"Cada [#488BD4]Célula[/colour] funciona de maneira semelhante a um [#488BD4]Data Slot[/colour]: ela segura um [#fafafa]Datacore[/colour] e o conecta ao sistema. A diferença principal é que as células estão organizadas como um grupo contíguo que forma o Vetor — elas pertencem a uma mesma sequência física e lógica.",
			
			"Para acessar uma célula, o sistema usa um número chamado índice. O índice indica a posição da célula dentro do vetor (começando em zero): a célula de índice 0 é a primeira, índice 1 a segunda, e assim por diante. Quando o sistema precisa ler ou escrever em uma célula, ele usa esse índice para localizar a posição exata e operar diretamente naquela célula.",
			
			"Os Vetores servem para mostrar como dados ou núcleos podem ser organizados em espaços contíguos: em vez de 'seguir' um caminho de nó a nó, aqui você coloca o Datacore diretamente na célula desejada — cada célula representa um slot posicional fixo dentro do vetor.",
			
			"Pense na célula como um Data Slot em linha: enquanto um Data Slot pode fazer parte de um nó (com um ponteiro ao lado), a célula participa de um agrupamento indexado — o Vetor — que não depende de torres ponteiros para localizar seus elementos.",
		]
	};

	d[$ "day2_room1_instructions"] = {
		title: "Primeira Tarefa com Arrays",
		pages: [
			"Nesta sala, você verá uma sequência de [#488BD4]nós[/colour] de uma lista encadeada preenchidos com datacores, exibindo a ordem correta. Ao topo da sala há um [#488BD4]Vetor[/colour] de células vazias. ",
			
			"Seu objetivo é copiar a sequência da lista e colocar os [#fafafa]Datacores[/colour] nas [#488BD4]Células[/colour] correspondentes, preenchendo o Vetor na mesma ordem mostrada pelos nós.",
			
			"Aproxime-se de uma célula e pressione [#78D7FF]E[/colour] para encaixar um datacore. Se quiser remover o datacore de um célula, pressione [#78D7FF]E[/colour] novamente — desde que suas mãos estejam livres.",
		]
	};

	d[$ "day3_array_concept"] = {
		title: "Conceito de Vetor",
		pages: [
			"Em termos técnicos, um vetor (ou array) organiza valores em um espaço contíguo de memória. A posição física de uma elemento pode ser calculada a partir de um endereço-base mais o índice vezes o tamanho do elemento (posição = base + índice * tamanho). Esse mapeamento é o que permite acessar diretamente qualquer elemento pelo seu índice."
		]
	};

	d[$ "day3_room2_concept"] = {
		title: "Inserção e Remoção",
		pages: [
			"Em uma lista encadeada, cada nó aponta para o próximo por meio de um ponteiro. Para remover um nó no meio da lista, basta ajustar o ponteiro do nó anterior para que ele passe a apontar para o seguinte — assim, o nó removido é simplesmente pulado. Já para inserir um novo nó, é preciso ligar o ponteiro do nó anterior ao novo nó, e então conectar o novo nó ao próximo, completando a cadeia novamente.",
			"Em um [#488BD4]Vetor[/colour], as [#928FB8]Células[/colour] formam um bloco contínuo na memória — não há ponteiros que permitam saltar posições. Por isso, quando você remove um elemento do meio, é necessário mover todos os elementos seguintes uma posição para trás, fechando o espaço vazio. Do mesmo modo, ao inserir um elemento no meio, é preciso deslocar os elementos à frente para abrir espaço.",
			"Com poucos elementos, essa diferença pode parecer pequena, mas em estruturas com centenas ou milhares de elementos o custo de mover cada célula cresce rapidamente. Por isso, em sistemas reais, a escolha entre uma [#488BD4]Lista Encadeada[/colour] ou um [#488BD4]Vetor[/colour] depende das operações que precisam ser feitas com mais frequência.",		
		]
	};
	




	d[$ "day3_room2_instructions"] = {
		title: "Reorganizando Estruturas",
		pages: [
			"Você está diante de dois pares de estruturas: [#488BD4]Listas Encadeadas[/colour] e [#488BD4]Vetores[/colour]. Cada par contém a mesma sequência de [#fafafa]Datacores[/colour].",
			"Seu trabalho é reorganizar as estruturas conforme os [#928FB8]painéis[/colour] de referência: no primeiro par, remova um [#fafafa]Datacore[/colour] do meio da sequência; no segundo par, insira esse mesmo [#fafafa]Datacore[/colour] na posição indicada.",
			"Nas [#488BD4]Listas Encadeadas[/colour], ajuste as ligações dos [#928FB8]ponteiros[/colour] para manter a sequência contínua. Nos [#488BD4]Vetores[/colour], mova os [#fafafa]Datacores[/colour] de modo que não reste nenhum espaço vazio entre as [#928FB8]Células[/colour].",		
		]
	};

	d[$ "day3_room3_concept"] = {
		title: "Leitura: Vetor vs Lista",
		pages: [
			"Aqui você verá como a informação é percorrida dentro de duas estruturas diferentes: o [#488BD4]Vetor[/colour] e a [#78D7FF]Lista Encadeada[/colour]. Ambas armazenam dados, mas o caminho até cada valor é bem distinto.",
			"No [#488BD4]Vetor[/colour], cada célula ocupa um espaço contíguo na memória. Isso permite que o sistema calcule a posição exata de qualquer elemento a partir de seu índice — sem precisar percorrer o restante da estrutura. É como abrir uma gaveta numerada e pegar o item certo de uma vez.",
			"Já na [#78D7FF]Lista Encadeada[/colour], os dados estão distribuídos em diferentes endereços de memória, conectados por ponteiros. Cada nó sabe apenas onde está o próximo, então para encontrar um elemento específico, é preciso seguir essa corrente, nó por nó, até alcançá-lo.",
			"Durante a simulação, o painel central exibirá o índice atual e alternará entre as duas leituras. No [#488BD4]Vetor[/colour], a célula correspondente será iluminada de imediato; na [#78D7FF]Lista[/colour], os nós acenderão em sequência até chegar ao valor pedido.",
			"Você não precisa realizar nenhuma ação nesta sala — apenas observe e perceba como cada estrutura lida com o processo de leitura de um valor."
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

