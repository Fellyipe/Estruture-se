text = 
"Você atravessa a porta do RH. O turno terminou - por enquanto.\n\n" +
"Nos últimos dias você montou cadeias, encaixou Datacores, editou endereços e reorganizou Vetores. Essas ações tinham um propósito prático: fazer a energia e a informação seguir a rota prevista.\n\n" +
"O que acabou de praticar aqui não é só jogo: você viu, na prática, conceitos centrais - seguir referências com ponteiros, percorrer nós em sequência, preencher e reorganizar células de um vetor, e as consequências práticas dessas escolhas.\n\n" +
"Em termos simples: aprendeu a seguir uma sequência (travessia), a alterar ligações locais (inserir/remover nós) e a trabalhar com posições fixas (índice em vetor). Cada técnica tem vantagens e custos - e isso é o que orienta decisões em sistemas reais.\n\n" +
"Se seu objetivo foi aprender, ótimo - isso foi proposital. Se veio só para brincar, obrigado pela companhia. Seja como for, você agora tem um mapa mental desses mecanismos - e pode reconhecê-los fora daqui, em código ou em sistemas maiores.\n\n" +
"AetherGrid continuará a rodar. Foram feitos ajustes, registros e relatórios; você fez parte disso. Há mais perguntas remanescentes, e mais peças da rede esperando manutenção - mas isso deixaremos para uma próxima.\n\n" +
"Obrigado por jogar.\n" +
"Créditos\n> Desenvolvido por: Felipe Bueno\n> Professor Orientador: Jorge Aikes Junior\n> Protótipo para Trabalho de Conclusão de Curso\n> Engine utilizada: GameMaker Studio 2";


paragraphs = string_split(text, "\n\n");

next_room = rm_main_menu;

panel_w_scale = 0.88;
panel_h_scale = 0.88;