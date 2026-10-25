import 'package:flutter/material.dart';

/// O AnimatedContainer não serve apenas para tamanhos; ele também pode interpolar cores e gradientes.
/// Quando o setState é chamado trocando o LinearGradient, o widget faz um "fade" entre eles.
/// Isso evita mudanças bruscas de estilo, tornando transições de temas ou status muito elegantes.
/// Todo o cálculo matemático complexo da mistura de cores é feito internamente pelo Flutter.
class AnimatedContainerGradient extends StatefulWidget {
  const AnimatedContainerGradient({super.key});
  @override
  State<AnimatedContainerGradient> createState() => _AnimatedContainerGradientState();
}

class _AnimatedContainerGradientState extends State<AnimatedContainerGradient> {
  bool _isFirstGradient = true; // Controla qual gradiente exibir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer/gradient')),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() => _isFirstGradient = !_isFirstGradient),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                // Alterna entre gradiente vermelho/amarelo e azul/roxo
                colors: _isFirstGradient 
                  ? [Colors.red, Colors.yellow] 
                  : [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
