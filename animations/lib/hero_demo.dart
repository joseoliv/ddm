import 'package:flutter/material.dart';

/// O widget Hero é utilizado para criar animações de transição visual entre duas telas.
/// Ele funciona conectando dois widgets em rotas diferentes através de uma mesma "tag".
/// Quando a navegação ocorre, o Flutter anima o widget da posição e tamanho originais para os novos.
/// É muito útil para imagens em listas que se expandem para mostrar detalhes.
class HeroDemo extends StatelessWidget {
  const HeroDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero')),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            SlowMaterialPageRoute<Widget>(builder: (_) => const HeroDetail()),
          ),
          // A tag 'hero-box' conecta este container ao da próxima tela
          child: Hero(
            tag: 'hero-box',
            child: Container(width: 100, height: 100, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class HeroDetail extends StatelessWidget {
  const HeroDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Detail')),
      body: Align(
        alignment: Alignment.topCenter,
        // O Hero vai animar suavemente até este novo tamanho e posição
        child: Hero(
          tag: 'hero-box',
          child: Container(
            width: double.infinity,
            height: 300,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class SlowMaterialPageRoute<T> extends MaterialPageRoute<T> {
  SlowMaterialPageRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);
}
