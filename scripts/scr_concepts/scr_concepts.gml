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
 
    d[$ "teste"] = {
        title: "Inserção e Remoção",
        pages: [
			"Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque sem placerat in id cursus mi pretium tellus duis convallis tempus leo eu aenean sed diam urna tempor pulvinar vivamus fringilla lacus nec metus bibendum egestas iaculis massa nisl malesuada lacinia integer nunc posuere ut hendrerit semper vel class aptent taciti sociosqu ad litora torquent per conubia nostra inceptos himenaeos orci varius natoque (Tamanho máximo).",
            "Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque sem placerat in id cursus mi pretium tellus duis convallis tempus leo eu aenean sed diam urna tempor pulvinar (Tamanho recomendado).",
            "Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque sem placerat in id (Tamanho mais curto, bom para textos pequenos).",
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




	
	/*
	
	concepts_data = {};

/// --- INTRO (narrativa + fluxo do dia) ---
concepts_data[$ "intro"] = {
    title: "Boas-vindas — Manual do Técnico",
    pages: [
        // Página 1 — narrativa curta
        "Bem-vindo à AetherGrid Systems. Você é o novo técnico de manutenção 
        alocado no turno de rotina. Seu trabalho é inspeccionar e consertar os módulos 
        AetherCores — pequenos cristais de energia que guardam metadados e impulsionam cargas. 
        Todo dia você recebe um briefing no PDA: entra no hub, checa as tarefas, vai às salas 
        designadas, completa as manutenções e volta ao RH para registrar o relatório do dia.",
        // Página 2 — fluxo prático (curto)
        "O fluxo de um dia: (1) passe pelo hub e leia o briefing no tablet; (2) vá até a sala 
        indicada; (3) execute as manutenções (puzzles) — cada sala tem objetivos claros; (4) 
        quando as tarefas estiverem completas a porta abre; (5) retorne ao lobby e entregue o 
        relatório no RH. Repita nos próximos dias.",
        // Página 3 — tom e propósito
        "Estes textos explicam os conceitos por trás das mecânicas que você verá durante a 
        manutenção — ponteiros, nós, listas e racks (arrays). As salas são exercícios práticos: 
        observe, experimente e relacione as ações que você faz com a explicação aqui. O tom é 
        técnico, porém acessível; sempre que quiser, abra o tablet e releia.",
        "Resumo dos três dias: Dia 1 — Ponteiros: como um módulo aponta para outro; Dia 2 — 
        Nós e listas: cada nó junta um ponteiro a um data-core (dado) e as listas mostram 
        encadeamento; Dia 3 — Arrays (FluxRacks): sequência indexada de slots, com diferenças 
        práticas na leitura e na modificação. Ao terminar o terceiro dia haverá um epílogo 
        narrativo que fecha a experiência.",
        // Página 5 — instrução de uso do tablet
        "Dica rápida: use o tablet sempre que precisar relembrar a teoria. As páginas têm 
        estrutura modular (você pode abrir cada módulo e navegar por páginas). Textos com 
        marcação especial '[TÉCNICO]' apresentam explicações mais 'reais' — exiba-os em cor 
        diferente para indicar que são leituras mais profundas."
    ]
};

concepts_data = {};

/// --- INTRO: apareceria no tablet no começo do jogo (mensagem "Boas-vindas")
concepts_data[$ "intro"] = {
    title: "Boas-vindas — AetherGrid Systems",
    pages: [
        // 1
        "Há poucos anos, campos cristalinos foram descobertos em um vale remoto — pedaços de um " +  
		"mineral que reagem com sinais elétricos de formas que a ciência ainda descreve com cautela.", 
		"São cristais que acumulam e transportam energia e, estranhamente, configuram e preservam " +
		"padrões de informação.",
		"A AetherGrid nasceu daí: transformar esse estranho presente em infraestrutura.",// *Explicar um pouco mais de lore da empresa, talvez falando dos pesquisadores e engenheiros, e tbm falar do que ela faz em si* ",
		//*Aqui vou começar a escrever, e queria que você me fizesse as devidas correções, pro texto ficar melhor*
		"Entretanto, esses cristais são instáveis se não manuseados corretamente, e, se tratando de uma nova " +
		"tecnologia, os sitemas da empresa que utilizam esses cristais frequentemente precisam de manutenção.",
		"Entretanto, o serviço é de alto risco, e necessita de pessoas capacidades para tal. E é aí que entra você!"]
	}
concepts_data[$ "intro"] = {
    title: "Boas-vindas — AetherGrid Systems",
    pages: [
		Hoje você começa como técnico de manutenção do campus.",
        // 2
        "O seu trabalho é simples no enunciado e perigoso na prática: entrar nas salas controladas 
		por AetherCores, colocar os cristais em seus soquetes, ajustar as conexões e devolver o 
		fluxo em segurança. O tablet que você carrega é tanto guia quanto diário: use-o para 
		receber briefings, rever instruções e abrir módulos conceituais quando ficar em dúvida.",
        // 3
        "Cada dia tem uma rotina: no hub você confere o briefing; atravessa a porta do turno (o 
		'elevador') e entra no setor de manutenção; resolve as salas que aparecem na lista do 
		tablet; quando todas as tarefas são concluídas, a porta principal do setor se abre — volte 
		ao lobby e registre o relatório no RH para encerrar o dia.",
        // 4
        "Enquanto estiver numa sala, o tablet mostra objetivos e dicas concisas. Não espere que o 
		tablet entregue soluções: ele explica o funcionamento dos aparelhos — como os cristais 
		respondem, como as torres se conectam, e o que se espera das manutenções. Se precisar, abra 
		o tablet e releia o módulo correspondente.",
        // 5
        "Nota rápida: as palavras no chão da fábrica podem ter nomes próprios (Torre, Cabo, 
		FluxRack, Data-core). No manual dentro do tablet, usamos termos que ajudam a relacionar os 
		objetos da sala com a tecnologia real por trás deles. Páginas com a marca '[TÉCNICO]' 
		trazem notas mais fiéis ao mundo real; leia com atenção se quiser saber a versão científica 
		por trás da operação."
    ]
};


/// --- DAY 01: Ponteiros e Cristais (módulo que será desbloqueado no Dia 1)
concepts_data[$ "day_01_pointers"] = {
    title: "Dia 1 — Ponteiros & Cristais",
    pages: [
        // 1: abertura / cenário
        "Hoje você será introduzido ao mecanismo mais fundamental da rede AetherGrid: como um 
		módulo direciona energia e informação para outro. Nas salas, você verá pequenas torres 
		com um encaixe para cristal — quando um cristal é colocado, a torre pode transmitir 
		energia por meio de um cabo que aponta para outra torre. Entender esse fluxo é o primeiro 
		passo para manter a rede estável.",
        // 2: como é na prática (jogo)
        "Na sala, cada torre tem uma etiqueta (A, B, C...). Para configurar uma ligação, insira 
		um cristal no encaixe e edite o 'endereço' da torre (aperte R quando estiver perto). O 
		endereço aponta para outra torre — pense nisso como escrever no cabo a placa do destino. 
		Se a cadeia de torres forma um caminho correto, a energia atravessa de um cristal ao 
		outro e a porta da sala abre.",
        // 3: comportamento das energias (regra do jogo em mundo)
        "Algumas regras visíveis: uma torre só transmite se tiver um cristal encaixado e se 
		receber energia de outra torre que aponte para ela (com exceção de torres marcadas como 
		'head', que vêm com fonte própria). Se uma torre no caminho perde o cristal, tudo que vem 
		depois perde a energia também. Por isso, consertos que mexem em endereços afetam a 
		corrente mais adiante.",
        // 4: interação e atenção (controle)
        "Se estiver preso, lembre-se: 1) verifique se a torre que deveria ser a fonte (head) está 
		energizada; 2) confira se as torres intermediárias têm cristais encaixados; 3) abra o 
		tablet para comparar o esquema da parede com a configuração atual. Pequenas trocas de 
		endereço fazem grandes mudanças no fluxo.",
        // 5: exemplo narrativo (cenário da sala 3 do dia)
        "Em algumas salas você encontrará cristais que não podem ser removidos — eles estão 
		presos pela segurança. Em outras haverá sinais de proteção: postes que geram campos 
		elétricos enquanto [X] estiverem energizados. Cautela ao editar endereços: às vezes a 
		solução é interromper um caminho (apontando para 'null') para desativar um circuito e 
		abrir passagem.",
        // 6: design de puzzles (explicação imersa)
        "As primeiras salas propõem exercícios curtos: ligar A → B, depois sequências maiores. 
		Mais adiante você verá combinações que exigem pensar em cadeias: ao rearranjar endereços 
		você está, na prática, reprogramando o roteiro da energia. O objetivo é restaurar o fluxo 
		sem causar instabilidade — pequenas sobrecargas geram falhas temporárias.",
        // 7: [TÉCNICO] (marcar visualmente diferente)
        "[TÉCNICO] Em termos práticos, um 'ponteiro' em software é um valor que representa o 
		endereço de memória de outro bloco. No protótipo, tratamos o endereço como um rótulo 
		legível; 'head' equivale a uma fonte alimentada. É importante entender que, em sistemas 
		reais, referências e alocação de memória exigem mecanismos de segurança e gerenciamento 
		(por isso nos restringimos a um modelo controlado para os puzzles)."
    ]
};


/// --- DAY 02: NÓS (ponteiro + data-core) ---
concepts_data[$ "day_02_nodes"] = {
    title: "Dia 2 — Nós: juntar ponteiro + dado",
    pages: [
        // Página 1 — introdução concisa
        "Hoje você trabalha com nós: estruturas pequenas compostas por uma torre que aponta 
		(o 'cabo') e um data-core (o cristal) que guarda o valor. Pense em cada nó como uma 
        pequena caixa com um cabo preso — o cabo diz para qual caixa a corrente deve ir, e o 
        cristal contém o que a caixa guarda.",
        // Página 2 — o que é um nó, em linguagem do jogo
        "No mundo da AetherGrid: Torre = nó; Cabo = ponteiro; Data-core = valor. Na sala você 
        verá pares: uma torre que armazena um cristal e outro objeto que funciona como seu cabo. 
        A ação principal é: colocar um data-core no slot do nó e editar o cabo para apontar ao 
        próximo nó.",
        // Página 3 — analogia prática (didática)
        "Analogia: imagine uma fila de fichas postais. Cada ficha contém um pedaço de informação 
        (o cristal) e um bilhete dizendo para qual ficha enviar a próxima mensagem (o cabo). Para 
        percorrer a fila você segue os bilhetes, um a um — isso ilustra o encadeamento.",
        // Página 4 — comportamento em jogo (feedback & regras)
        "Regras essenciais (resumo para usar na sala): (1) um nó transmite energia para o próximo 
        somente se tiver um cristal encaixado; (2) o ponteiro do nó é editável (você decide o 
        endereço); (3) se um nó deixa de receber energia, ele não transmite adiante — e isso 
        apaga a corrente nos nós subsequentes até que uma fonte (head) reenergize a cadeia.",
        
        "Objetivo pedagógico: aprender a diferença entre 'apontar' e 'conter'. Em uma lista, a 
        ordem e a conexão são definidas por ponteiros; mover/alterar ponteiros altera o fluxo sem 
        trocar necessariamente os dados. Pratique: insira, remova ou reconecte nós e observe como 
        a corrente muda.",
        
        "Atenção: dois ponteiros podem apontar para o mesmo data-core. Isso é aliasing — duas 
        referências para o mesmo valor. Uma modificação no dado afetará todas as referências. Em 
        puzzles, esse comportamento pode criar efeitos interessantes (ou armadilhas).",
        
        "[TÉCNICO] Em sistemas reais, um 'ponteiro' é uma referência a um endereço de memória; um 
        'nó' em uma lista encadeada é um bloco de memória que contém um dado e um endereço (ou 
        referência) para o próximo bloco. 'Aliasing' ocorre quando várias referências apontam 
        para a mesma posição; a gestão de memória (alocação e liberação) é feita pelo sistema — 
        no protótipo simplificamos isso com um pool controlado para evitar erros de referência."
    ]
};


    // ... adicionar mais conceitos ...
*/
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

