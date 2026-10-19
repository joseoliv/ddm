import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Widgets Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/listview': (context) => const ListViewPage(),
        '/listview_column': (context) => const ListViewInColumnPage(),
        '/scrollview': (context) => const SingleChildScrollViewPage(),
        '/mediaquery': (context) => const MediaQueryPage(),
        '/form': (context) => const FormPage(),
        '/outro': (context) => const OutroInputPage(),
        '/stack': (context) => const StackPage(),
      },
    );
  }
}

// ============================================================================
// TELA PRINCIPAL: Wrap centralizado na tela com as opções
// ============================================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final opcoes = <Map<String, String>>[
      {'titulo': 'ListView', 'rota': '/listview'},
      {'titulo': 'ListView dentro de Column', 'rota': '/listview_column'},
      {'titulo': 'SingleChildScrollView', 'rota': '/scrollview'},
      {'titulo': 'MediaQuery', 'rota': '/mediaquery'},
      {'titulo': 'Form', 'rota': '/form'},
      {'titulo': 'Outro', 'rota': '/outro'},
      {'titulo': 'Stack', 'rota': '/stack'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal (Wrap)'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Wrap(
            spacing: 16.0, // Espaçamento horizontal entre os botões
            runSpacing: 16.0, // Espaçamento vertical entre as linhas
            alignment: WrapAlignment.center,
            children: opcoes.map((opcao) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, opcao['rota']!);
                },
                child: Text(
                  opcao['titulo']!,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 1. "ListView": Países do mundo com língua e população usando ListView.separated
// ============================================================================
class Pais {
  final String nome;
  final String linguas;
  final String populacao;

  const Pais(this.nome, this.linguas, this.populacao);
}

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  // Lista representativa de países dos 5 continentes (expansível para todos os 195)
  static const List<Pais> paises = [
    Pais('Afeganistão', 'Pashto, Dari', '41.128.771'),
    Pais('África do Sul', 'Inglês, IsiZulu, IsiXhosa, Africâner', '59.893.885'),
    Pais('Albânia', 'Albanês', '2.775.634'),
    Pais('Alemanha', 'Alemão', '83.797.985'),
    Pais('Angola', 'Português', '35.588.987'),
    Pais('Arábia Saudita', 'Árabe', '36.408.820'),
    Pais('Argélia', 'Árabe, Tamazight', '44.903.225'),
    Pais('Argentina', 'Espanhol', '46.234.830'),
    Pais('Austrália', 'Inglês', '26.005.540'),
    Pais('Áustria', 'Alemão', '9.041.851'),
    Pais('Bangladesh', 'Bengali', '171.186.372'),
    Pais('Bélgica', 'Holandês, Francês, Alemão', '11.686.140'),
    Pais('Bolívia', 'Espanhol, Quéchua, Aimará', '12.224.110'),
    Pais('Brasil', 'Português', '203.080.756'),
    Pais('Cabo Verde', 'Português', '593.149'),
    Pais('Camarões', 'Inglês, Francês', '27.914.536'),
    Pais('Canadá', 'Inglês, Francês', '38.929.902'),
    Pais('Chile', 'Espanhol', '19.603.733'),
    Pais('China', 'Mandarim', '1.412.175.000'),
    Pais('Colômbia', 'Espanhol', '51.874.024'),
    Pais('Coreia do Sul', 'Coreano', '51.628.117'),
    Pais('Costa Rica', 'Espanhol', '5.180.829'),
    Pais('Croácia', 'Croata', '3.855.641'),
    Pais('Cuba', 'Espanhol', '11.212.191'),
    Pais('Dinamarca', 'Dinamarquês', '5.903.037'),
    Pais('Egito', 'Árabe', '110.990.103'),
    Pais('Equador', 'Espanhol', '18.001.000'),
    Pais('Espanha', 'Espanhol, Catalão, Galego, Basco', '47.778.340'),
    Pais('Estados Unidos', 'Inglês', '333.287.557'),
    Pais('Etiópia', 'Amárico', '123.379.924'),
    Pais('Filipinas', 'Filipino, Inglês', '115.559.009'),
    Pais('Finlândia', 'Finlandês, Sueco', '5.556.106'),
    Pais('França', 'Francês', '67.971.311'),
    Pais('Gana', 'Inglês', '33.475.870'),
    Pais('Grécia', 'Grego', '10.426.919'),
    Pais('Guatemala', 'Espanhol', '17.357.886'),
    Pais('Guiné-Bissau', 'Português', '2.105.566'),
    Pais('Haiti', 'Francês, Crioulo Haitiano', '11.584.996'),
    Pais('Holanda (Países Baixos)', 'Holandês', '17.700.967'),
    Pais('Hungria', 'Húngaro', '9.643.048'),
    Pais('Índia', 'Hindi, Inglês', '1.417.173.173'),
    Pais('Indonésia', 'Indonésio', '275.501.339'),
    Pais('Irã', 'Persa', '88.550.570'),
    Pais('Iraque', 'Árabe, Curdo', '44.496.122'),
    Pais('Irlanda', 'Irlandês, Inglês', '5.127.170'),
    Pais('Islândia', 'Islandês', '382.003'),
    Pais('Israel', 'Hebraico, Árabe', '9.557.500'),
    Pais('Itália', 'Italiano', '58.940.425'),
    Pais('Jamaica', 'Inglês', '2.827.377'),
    Pais('Japão', 'Japonês', '125.124.989'),
    Pais('Marrocos', 'Árabe, Amazigh', '37.457.971'),
    Pais('México', 'Espanhol', '127.504.125'),
    Pais('Moçambique', 'Português', '32.969.518'),
    Pais('Nigéria', 'Inglês, Hausa, Yoruba, Igbo', '218.541.212'),
    Pais('Noruega', 'Norueguês', '5.457.127'),
    Pais('Nova Zelândia', 'Inglês, Maori', '5.124.100'),
    Pais('Panamá', 'Espanhol', '4.408.581'),
    Pais('Paquistão', 'Urdu, Inglês', '235.824.862'),
    Pais('Paraguai', 'Espanhol, Guarani', '6.780.744'),
    Pais('Peru', 'Espanhol, Quéchua, Aimará', '34.049.588'),
    Pais('Polônia', 'Polonês', '36.821.749'),
    Pais('Portugal', 'Português', '10.405.836'),
    Pais('Quênia', 'Inglês, Suaíli', '54.027.487'),
    Pais('Reino Unido', 'Inglês', '66.971.411'),
    Pais('Rússia', 'Russo', '143.555.736'),
    Pais('São Tomé e Príncipe', 'Português', '227.380'),
    Pais('Senegal', 'Francês', '17.316.449'),
    Pais('Suécia', 'Sueco', '10.486.941'),
    Pais('Suíça', 'Alemão, Francês, Italiano, Romanche', '8.775.760'),
    Pais('Tailândia', 'Tailandês', '71.697.030'),
    Pais('Timor-Leste', 'Português, Tétum', '1.341.296'),
    Pais('Turquia', 'Turco', '84.979.913'),
    Pais('Ucrânia', 'Ucraniano', '38.000.000'),
    Pais('Uruguai', 'Espanhol', '3.422.794'),
    Pais('Venezuela', 'Espanhol', '28.301.696'),
    Pais('Vietnã', 'Vietnamita', '98.186.856'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.separated - Países'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12.0),
        itemCount: paises.length,
        separatorBuilder: (context, index) => const Divider(
          height: 12,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          final pais = paises[index];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  pais.nome.substring(0, 2).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              title: Text(
                pais.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Línguas principais: ${pais.linguas}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'População',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    pais.populacao,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// 2. "ListView dentro de Column": Uso de Expanded para restringir a altura
// ============================================================================
class ListViewInColumnPage extends StatelessWidget {
  const ListViewInColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView dentro de Column'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.amber.shade100,
            child: const Text(
              'Cabeçalho fixo no topo da Column.\n'
              'O ListView abaixo está envolvido em um widget Expanded para '
              'evitar erro de altura infinita (unbounded height).',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.label_important_outline),
                  title: Text('Item da Lista #${index + 1}'),
                  subtitle: const Text('Rolagem independente dentro da Column'),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.indigo.shade100,
            child: const Text(
              'Rodapé fixo no final da Column',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. "SingleChildScrollView": Uso combinado com Column e ListView
// ============================================================================
class SingleChildScrollViewPage extends StatelessWidget {
  const SingleChildScrollViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingleChildScrollView'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              color: Colors.tealAccent,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Bloco 1 (Dentro da Column)\n'
                  'A página inteira rola como uma única unidade graças ao '
                  'SingleChildScrollView. O ListView abaixo utiliza '
                  'shrinkWrap: true e NeverScrollableScrollPhysics.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'ListView Embutido:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true, // Calcula a altura total com base nos filhos
              physics: const NeverScrollableScrollPhysics(), // Delega a rolagem ao SingleChildScrollView pai
              itemCount: 15,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text('Elemento do ListView ${index + 1}'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Final da Column (após o ListView)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 4. "MediaQuery": Muda a cor do background do Scaffold conforme o tamanho da tela
// ============================================================================
class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({super.key});

  Color _calcularCorDeFundo(double largura) {
    if (largura < 450) {
      return Colors.lightBlue.shade100; // Telas pequenas (Celulares)
    } else if (largura < 750) {
      return Colors.lightGreen.shade100; // Telas médias (Tablets compactos / Janela média)
    } else if (largura < 1050) {
      return Colors.amber.shade100; // Telas grandes (Tablets / Laptops)
    } else {
      return Colors.purple.shade100; // Telas muito grandes (Desktop Widescreen)
    }
  }

  String _faixaDeTamanho(double largura) {
    if (largura < 450) return 'Pequena (< 450px) - Azul';
    if (largura < 750) return 'Média (450px a 749px) - Verde';
    if (largura < 1050) return 'Grande (750px a 1049px) - Amarelo';
    return 'Extra Grande (>= 1050px) - Roxo';
  }

  @override
  Widget build(BuildContext context) {
    final tamanho = MediaQuery.sizeOf(context);
    final largura = tamanho.width;
    final altura = tamanho.height;

    return Scaffold(
      backgroundColor: _calcularCorDeFundo(largura),
      appBar: AppBar(
        title: const Text('MediaQuery Dinâmico'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.aspect_ratio, size: 48, color: Colors.indigo),
                const SizedBox(height: 16),
                Text(
                  'Dimensões Atuais da Tela',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'Largura: ${largura.toStringAsFixed(1)} px\n'
                  'Altura: ${altura.toStringAsFixed(1)} px',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const Divider(height: 32),
                Text(
                  'Faixa atual: ${_faixaDeTamanho(largura)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Redimensione a janela ou gire o dispositivo para ver a cor de fundo mudar!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 5. "Form": Nome, CPF e idade com validação de CPF e idade
// ============================================================================
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _idadeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  // Algoritmo oficial de validação dos dígitos verificadores do CPF
  bool _validarCPF(String cpf) {
    final numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeros.length != 11) return false;

    // Rejeita CPFs com todos os dígitos iguais (ex: 111.111.111-11)
    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;

    List<int> digitos = numeros.split('').map(int.parse).toList();

    // Cálculo do 1º dígito verificador
    int soma1 = 0;
    for (int i = 0; i < 9; i++) {
      soma1 += digitos[i] * (10 - i);
    }
    int resto1 = (soma1 * 10) % 11;
    if (resto1 == 10) resto1 = 0;
    if (resto1 != digitos[9]) return false;

    // Cálculo do 2º dígito verificador
    int soma2 = 0;
    for (int i = 0; i < 10; i++) {
      soma2 += digitos[i] * (11 - i);
    }
    int resto2 = (soma2 * 10) % 11;
    if (resto2 == 10) resto2 = 0;
    if (resto2 != digitos[10]) return false;

    return true;
  }

  void _submeterFormulario() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Dados válidos! Nome: ${_nomeController.text}, '
            'CPF: ${_cpfController.text}, Idade: ${_idadeController.text}',
          ),
          backgroundColor: Colors.green.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form e Validação'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Por favor, informe o nome.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CPF (apenas números ou com pontuação)',
                  hintText: '000.000.000-00',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'O CPF é obrigatório.';
                  }
                  if (!_validarCPF(valor)) {
                    return 'CPF inválido. Verifique os 11 dígitos.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'A idade é obrigatória.';
                  }
                  final idade = int.tryParse(valor.trim());
                  if (idade == null) {
                    return 'Digite um número inteiro válido.';
                  }
                  if (idade < 0 || idade > 130) {
                    return 'Informe uma idade realista (entre 0 e 130 anos).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submeterFormulario,
                icon: const Icon(Icons.check),
                label: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Validar e Enviar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 6. "Outro": Widgets da categoria "Handling User Input" (Slider, Switch, Chips, GestureDetector)
// ============================================================================
class OutroInputPage extends StatefulWidget {
  const OutroInputPage({super.key});

  @override
  State<OutroInputPage> createState() => _OutroInputPageState();
}

class _OutroInputPageState extends State<OutroInputPage> {
  double _volume = 50.0;
  bool _notificacoesAtivas = true;
  int _toques = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outro (Handling User Input)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: SwitchListTile(
                title: const Text('Ativar Notificações (Switch)'),
                subtitle: Text(_notificacoesAtivas ? 'Ativado' : 'Desativado'),
                value: _notificacoesAtivas,
                onChanged: (bool valor) {
                  setState(() => _notificacoesAtivas = valor);
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nível de Volume (Slider): ${_volume.round()}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _volume,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: _volume.round().toString(),
                      onChanged: (double novoValor) {
                        setState(() => _volume = novoValor);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _toques++),
                onDoubleTap: () => setState(() => _toques += 5),
                onLongPress: () => setState(() => _toques = 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.indigo, width: 2),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.touch_app, size: 56, color: Colors.indigo),
                      const SizedBox(height: 12),
                      Text(
                        'Contador GestureDetector: $_toques',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Toque simples: +1\n'
                        '• Toque duplo: +5\n'
                        '• Toque longo: Zerar',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 7. "Stack": Elementos posicionados com Positioned dentro de um Stack
// ============================================================================
class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack & Positioned'),
      ),
      body: Center(
        child: Container(
          width: 340,
          height: 420,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Stack(
            children: [
              // Fundo decorativo superior
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 140,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                ),
              ),
              // Caixa no canto superior esquerdo
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'top: 16, left: 16',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // Ícone no canto superior direito
              const Positioned(
                top: 16,
                right: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.star, color: Colors.black87),
                ),
              ),
              // Card centralizado sobrepondo a divisão azul/cinza
              Positioned(
                top: 90,
                left: 30,
                right: 30,
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.indigoAccent,
                          child: Icon(Icons.layers, size: 36, color: Colors.white),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Card Sobreposto',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Posicionado em top: 90, left: 30, right: 30',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Botão flutuante no canto inferior direito
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('bottom: 20, right: 20'),
                ),
              ),
              // Etiqueta no canto inferior esquerdo
              Positioned(
                bottom: 28,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal.shade700,
                  child: const Text(
                    'bottom: 28\nleft: 20',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}