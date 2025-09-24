# Sugestões para o Trabalho em Grupo

Texto ainda sendo atualizado

- aplicativo para gerenciamento de um consultório, studio de pilates, etc.
- aplicativo com recursos para o ENEM (este dá vários trabalhos)


## Sobre Grupos e Notas

- O grupo deve ter no máximo 3 alunos
- o trabalho é um só mas dividido em três entregas, cada uma contando como um trabalho para fins de nota

## Observações Gerais

Estas observações se aplicam a todos os trabalhos. O aplicativo deve ser minimamente viável (Minimum Viable Product). Ou seja, deve ser possível usá-lo para uma finalidade útil. Além disto, o aplicativo deve seguir as seguintes especificações.


* login pelo firebase, supabase ou equivalente. Deve ser possível logar pela Google. 
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
    