import 'package:flutter/material.dart';

/// O PositionedTransition é uma animação explícita feita para mover widgets dentro de um Stack.
/// Ele precisa de uma animação que interpole objetos do tipo 'RelativeRect'.
/// É mais poderoso que o AnimatedPositioned por ser explícito, permitindo pausar e reverter via código.
/// Geralmente usado para movimentos complexos coreografados.
class PositionedTransitionDemo extends StatefulWidget {
  const PositionedTransitionDemo({super.key});
  @override
  State<PositionedTransitionDemo> createState() => _PositionedTransitionDemoState();
}

class _PositionedTransitionDemoState extends State<PositionedTransitionDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<RelativeRect> _rectAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
    
    _rectAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(10, 10, 200, 200),
      end: const RelativeRect.fromLTRB(200, 200, 10, 10),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PositionedTransition')),
      body: Stack(
        children: [
          PositionedTransition(
            rect: _rectAnimation, // Aplica o movimento relativo
            child: Container(color: Colors.lime),
          ),
        ],
      ),
    );
  }
}
