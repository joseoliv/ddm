import 'package:flutter/material.dart';

/// O AnimatedBuilder é usado para melhorar a performance das animações explícitas.
/// Em vez de chamar setState() e reconstruir toda a tela a cada frame, ele reconstrói apenas seu builder.
/// Você passa o Animation (ou Controller) para ele, e ele escuta as mudanças automaticamente.
/// É a maneira mais recomendada de vincular um Controller à interface gráfica.
class AnimatedBuilderDemo extends StatefulWidget {
  const AnimatedBuilderDemo({super.key});
  @override
  State<AnimatedBuilderDemo> createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedBuilder')),
      body: Center(
        // O AnimatedBuilder reconstrói apenas o Transform, otimizando o processo
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * 3.14159,
              child: child, // O container colorido abaixo não será recriado, apenas rotacionado
            );
          },
          child: Container(width: 150, height: 150, color: Colors.cyan),
        ),
      ),
    );
  }
}
