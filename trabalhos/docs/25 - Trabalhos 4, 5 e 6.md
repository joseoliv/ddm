# Trabalho em Grupo

Este texto especifica o quarto, quinto e sexto trabalhos de DDM.  Este é um trabalho em grupo, que deve ter no máximo 3 alunos.
O trabalho é um só mas dividido em três entregas, cada uma contando como um trabalho para fins de nota.

  
## Especificação

O trabalho consiste de um aplicativo feito em um grupo de no máximo 3 pessoas. O aplicativo deve ser minimamente viável (Minimum Viable Product). Ou seja, deve ser possível usá-lo para uma finalidade útil. Além disto, o aplicativo deve seguir as seguintes especificações:

* login pelo firebase, supabase ou equivalente. Deve ser possível logar pela Google. Você pode usar o esqueleto fornecido pelo professor.
* opção de mudar o tema. Pelo menos duas opões: claro, escuro. Inicialmente, o app deve usar o tema padrão do dispositivo
* o aplicativo deve ter uma opção de mudar a língua. Pelo menos devem estar disponíveis: 
    - português
    - inglês
    - espanhol
    - francês
    - chinês
* deve-se usar o firebase ou supabase para guardar os dados dos usuários
* o aplicativo deve ser funcional pelo menos na web, em um dispositivo Android e em um iOS
* necessariamente use o flutter_riverpod para o gerenciamento de estado. Deve ter algum gerenciamento de estado
* o aplicativo deve ter pelo menos um acesso a alguma api de sua escolha. Sugestões: Youtube, Whatsapp, DeepSeek (ou Qwen ou alguma outra de IA), etc. 
* se o App for desligado e ligado novamente, ele deve voltar na página em que estava antes e na língua do último uso. Se isto não for possível, pelo menos restaure os dados da antiga página como campos de texto, tempo de vídeo, etc. Use SharedPreferences.
* uma animação qualquer    
* uma fonte que não seja a padrão
* um projeto não trivial de interface. Isto é, utilize sombras, cores adequadas, etc. Veja vídeos de projeto de aplicativos sobre os elementos básicos do projeto de uma interface. 
* adaptação para diferentes tipos de tela e sistemas operacionais. Use o widgetbook para testar.
* deve ser possível gerar 


As especificações do quarto, quinto e sexto trabalhos se seguem. 

### Quarto trabalho (10/nov)

Espera-se, para o quarto trabalho:

- a descrição do aplicativo em pelo menos uma página. Esta descrição pode ser aumentada ou diminuida a pedido do professor (para que os trabalhos ficam, aproximadamente, da mesma dificuldade)
- as telas feitas em Flutter (podem ser modificadas depois), a animação, a fonte padrão, o login usando o Firebase (faça a adaptação do código fornecido pelo professor, mas mude a interface)
- use o widgetbook 

### Quinto trabalho (24/nov)

- acesso à API
- gerenciamento de estado
- tema claro e escuro
- use o widgetbook

### Sexto trabalho (8/dez)

- internacionalização
- o aplicativo deve ser funcional
- use o widgetbook

## Orientações Gerais

Como é impossível eu corrigir todos os trabalhos e conferir tudo, vou fazer um questionário para vocês se auto-avaliarem. Durante a aula, vejo os trabalhos.

No AVA, entreguem apenas um zip (não RAR, não outra coisa) com os diretórios 'assets' e 'lib'. Coloque os nomes completos no nome do arquivo, separados por "-", utilizando  "Upper Camel Case" (assim: IsaacNewton-ThomasSankara), sem acentos e sem espaços.

## Sugestões para o Trabalho em Grupo


- aplicativo para gerenciamento de um consultório, studio de pilates, etc. As características deste aplicativo são: 
  * deve ter dois tipos de usuário: o profissional e o usuário (cliente)
  * o profissional pode escolher as datas de atendimento, o tipo de atendimento (ex: yoga, massagem relaxante, consulta médica, etc.) e o número de vagas para aquele horário. Deve ter uma opção para repetir da semana passada e guardar a agenda desta semana como padrão. Repita a agenda da semana passada por padrão
  * o usuário deve poder agendar uma sessão ou consulta dada a disponibilidade de vagas. Um dia antes, envie uma mensagem por Whatsapp avisando da sessão. Utilize um api intermediário para enviar mensagens para o Whatsapp (é bem mais barato)
- Refazer o jogo Emplake usando Flutter. Veja o jogo original em [https://www.cyan-lang.org/emplake](https://www.cyan-lang.org/emplake)
- Aplicativo para relógios com Android para monitoramento de idosos (muito importante!)
- aplicativo com recursos para o ENEM (este dá vários trabalhos). Como exemplos, veja sítios como  [https://estudeprisma.com/](https://estudeprisma.com/), [https://www.qconcursos.com/questoes-do-enem](https://www.qconcursos.com/questoes-do-enem), [https://brasilescola.uol.com.br/](https://brasilescola.uol.com.br/), etc. 
  
  * Correção automática de gabaritos - Um app que permita aos alunos marcar suas respostas dos simulados e receber a correção imediata, com análise de desempenho por disciplina e comparação com os colegas. (Pro CEC)

  * Agenda e planejamento de estudos - Aplicativo que funcione como um organizador: possibilite registrar provas, simulados e tarefas, além de criar planos de estudo personalizados. Pode sincronizar com calendários (como Google Calendar) para maior praticidade.

  * Gamificação do aprendizado - Aplicativos no estilo “quiz game” ou jogos educativos que tornam a revisão mais dinâmica e competitiva. Estimula o engajamento por meio de rankings, medalhas e desafios semanais.

  * Planner acadêmico integrado - Modelos como o UFSCar Planner (criado por alunos de Computação de São Carlos), que sincronizam com plataformas institucionais e organizam horários de aula automaticamente.

  * Banco de questões dos simulados - Um repositório digital onde os alunos possam acessar questões aplicadas em simulados anteriores, refazê-las e acompanhar seu progresso. Pode incluir explicações ou comentários dos professores para potencializar o aprendizado. (Pro CEC ou geral) 
