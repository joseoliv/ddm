# Sugestões para o Trabalho em Grupo

Texto ainda sendo atualizado

- aplicativo para gerenciamento de um consultório, studio de pilates, etc.
- Refazer o jogo Emplake usando Flutter. Veja o jogo original em https://www.cyan-lang.org/emplake
- aplicativo com recursos para o ENEM (este dá vários trabalhos): 
  * Correção automática de gabaritos - Um app que permita aos alunos marcar suas respostas dos simulados e receber a correção imediata, com análise de desempenho por disciplina e comparação com os colegas. (Pro CEC)

  * Agenda e planejamento de estudos - Aplicativo que funcione como um organizador: possibilite registrar provas, simulados e tarefas, além de criar planos de estudo personalizados. Pode sincronizar com calendários (como Google Calendar) para maior praticidade.

  * Gamificação do aprendizado - Aplicativos no estilo “quiz game” ou jogos educativos que tornam a revisão mais dinâmica e competitiva. Estimula o engajamento por meio de rankings, medalhas e desafios semanais.

  * Planner acadêmico integrado - Modelos como o UFSCar Planner (criado por alunos de Computação de São Carlos), que sincronizam com plataformas institucionais e organizam horários de aula automaticamente.

  * Banco de questões dos simulados - Um repositório digital onde os alunos possam acessar questões aplicadas em simulados anteriores, refazê-las e acompanhar seu progresso. Pode incluir explicações ou comentários dos professores para potencializar o aprendizado. (Pro CEC ou geral) 


## Sobre Grupos e Notas

- O grupo deve ter no máximo 3 alunos
- o trabalho é um só mas dividido em três entregas, cada uma contando como um trabalho para fins de nota

## Observações Gerais

Estas observações se aplicam a todos os trabalhos. O aplicativo deve ser minimamente viável (Minimum Viable Product). Ou seja, deve ser possível usá-lo para uma finalidade útil. Além disto, o aplicativo deve seguir as seguintes especificações.


* login pelo firebase, supabase ou equivalente. Deve ser possível logar pela Google. Use o pacote firebase_ui_auth. 
* opção de mudar o tema. Pelo menos duas opões: claro, escuro. Inicialmente, o app deve usar o tema padrão do dispositivo
* o aplicativo deve ter uma opção de mudar a língua. Pelo menos devem estar disponíveis: 
    - português
    - inglês
    - espanhol
    - francês
    - chines
* deve-se usar o firebase ou supabase para guardar os dados dos usuários
* o aplicativo deve ser funcional pelo menos na web, em um dispositivo Android e em um iOS
* necessariamente use o flutter_riverpod para o gerenciamento de estado. Deve ter algum gerenciamento de estado
* o aplicativo deve ter pelo menos um acesso a alguma api de sua escolha. Sugestões: Youtube, Whatsapp, DeepSeek (ou Qwen ou alguma outra de IA), etc. 
* se o App for desligado e ligado novamente, ele deve voltar na página em que estava antes. Se isto não for possível, pelo menos restaure os dados da antiga página como campos de texto, tempo de vídeo, etc. Use SharedPreferences.
    