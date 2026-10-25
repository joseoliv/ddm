import 'package:flutter/material.dart';

/// O FadeTransition manipula a opacidade de seu filho utilizando animação explícita.
/// Ele é preferido em vez de usar AnimatedBuilder com Opacity, pois é altamente otimizado pela engine gráfica.
/// É muito utilizado para fazer o conteúdo surgir suavemente na tela (fade-in) ou desaparecer (fade-out).
/// O valor de entrada no controller dita a transparência: 0.0 é invisível, 1.0 é totalmente opaco.
class FadeTransitionDemo extends StatefulWidget {
  const FadeTransitionDemo({super.key});
  @override
  State<FadeTransitionDemo> createState() => _FadeTransitionDemoState();
}

class _FadeTransitionDemoState extends State<FadeTransitionDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.repeat(reverse: true); // Faz um efeito pulsante de opacidade
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FadeTransition (Extra)')),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const FlutterLogo(size: 200),
        ),
      ),
    );
  }
}
