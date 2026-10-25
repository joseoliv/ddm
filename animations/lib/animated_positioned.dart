import 'package:flutter/material.dart';

/// O AnimatedPositioned é usado estritamente como filho de um widget Stack.
/// Ele anima automaticamente sua posição (top, bottom, left, right) quando esses valores mudam.
/// É extremamente útil para painéis deslizantes, notificações pop-up ou movimentação de cartas.
/// Elimina a necessidade de criar controladores complexos apenas para mover um elemento na tela.
class AnimatedPositionedDemo extends StatefulWidget {
  const AnimatedPositionedDemo({super.key});
  @override
  State<AnimatedPositionedDemo> createState() => _AnimatedPositionedDemoState();
}

class _AnimatedPositionedDemoState extends State<AnimatedPositionedDemo> {
  bool _isMoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedPositioned')),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            // Alterna a posição dependendo do booleano
            top: _isMoved ? 300.0 : 50.0,
            left: _isMoved ? 200.0 : 50.0,
            child: GestureDetector(
              onTap: () => setState(() => _isMoved = !_isMoved),
              child: Container(
                width: 100, height: 100, color: Colors.purple,
                child: const Center(child: Text('Mova-me', style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
