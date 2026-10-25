import 'package:flutter/material.dart';

/// O SizeTransition anima o tamanho do seu filho recortando-o dinamicamente (clip).
/// Ele revela ou esconde o conteúdo baseando-se no valor de um AnimationController.
/// É amplamente usado para expansão e colapso de menus, listas ou caixas de detalhes.
/// O eixo padrão é vertical, mas pode ser configurado para crescer horizontalmente.
class SizeTransitionDemo extends StatefulWidget {
  const SizeTransitionDemo({super.key});
  @override
  State<SizeTransitionDemo> createState() => _SizeTransitionDemoState();
}

class _SizeTransitionDemoState extends State<SizeTransitionDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SizeTransition')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (_controller.status == AnimationStatus.completed) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            child: const Text('Expandir/Encolher'),
          ),
          SizeTransition(
            sizeFactor: _animation, // Controla o tamanho de 0.0 a 1.0
            alignment: Alignment.center,
            child: Container(
              color: Colors.pink,
              height: 200,
              width: double.infinity,
              child: const Center(child: Text('Conteúdo Expandido!')),
            ),
          ),
        ],
      ),
    );
  }
}
