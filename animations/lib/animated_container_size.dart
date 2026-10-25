import 'package:flutter/material.dart';

/// AnimatedContainer é um widget implícito que anima automaticamente qualquer mudança em suas propriedades.
/// Diferente de um Container normal, ao alterar altura, largura ou cor, ele faz a transição de forma fluida.
/// Neste exemplo, apenas mudamos o tamanho no setState() e o Flutter calcula os frames intermediários.
/// É ideal para animações simples onde não precisamos de controle estrito sobre o tempo.
class AnimatedContainerSize extends StatefulWidget {
  const AnimatedContainerSize({super.key});
  @override
  State<AnimatedContainerSize> createState() => _AnimatedContainerSizeState();
}

class _AnimatedContainerSizeState extends State<AnimatedContainerSize> {
  bool _isLarge = false; // Controla o estado atual do tamanho

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer/size')),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() => _isLarge = !_isLarge),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            // Alterna os tamanhos baseando-se no booleano
            width: _isLarge ? 250.0 : 100.0,
            height: _isLarge ? 250.0 : 100.0,
            color: Colors.green,
            child: const Center(child: Text('Toque-me!', style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
