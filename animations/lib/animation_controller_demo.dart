import 'package:flutter/material.dart';

/// O AnimationController é o "maestro" das animações explícitas no Flutter.
/// Ele não sabe o que está sendo animado, apenas gera números (geralmente de 0.0 a 1.0) ao longo do tempo.
/// Usamos os métodos .forward(), .reverse() ou .repeat() para controlar a reprodução.
/// Sem ele, não teríamos controle de quando iniciar, parar ou reverter uma animação.
class AnimationControllerDemo extends StatefulWidget {
  const AnimationControllerDemo({super.key});
  @override
  State<AnimationControllerDemo> createState() => _AnimationControllerDemoState();
}

class _AnimationControllerDemoState extends State<AnimationControllerDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // Escuta as mudanças de valor e notifica a UI para reconstruir
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimationController')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Usa o valor do controlador (0.0 a 1.0) para definir a altura visual do objeto
            Container(
              width: 100 + (_controller.value * 200),
              height: 50 + (_controller.value * 200), // Varia de 50 a 250
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => _controller.forward(), child: const Text('Forward')),
                ElevatedButton(onPressed: () => _controller.reverse(), child: const Text('Reverse')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
