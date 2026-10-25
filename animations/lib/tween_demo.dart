import 'package:flutter/material.dart';

/// O Tween (abreviação de 'in-between') não é um widget, mas sim uma classe utilitária de matemática.
/// Ele mapeia um valor de entrada (como tempo de 0.0 a 1.0) para um valor de saída correspondente.
/// Neste exemplo, demonstramos como um Tween avalia a interpolação entre dois números.
/// Usamos um AnimationController para fornecer o valor de 0 a 1 que o Tween irá traduzir.
class TweenDemo extends StatefulWidget {
  const TweenDemo({super.key});
  @override
  State<TweenDemo> createState() => _TweenDemoState();
}

class _TweenDemoState extends State<TweenDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // Criamos um Tween que mapeia de 0 a 300
  final Tween<double> _sizeTween = Tween<double>(begin: 50.0, end: 300.0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(() { setState(() {}); }) // Reconstroi a tela a cada frame
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos tween.evaluate para pegar o tamanho exato baseado no progresso atual (0 a 1) do controller
    double currentSize = _sizeTween.evaluate(_controller);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Tween<T>')),
      body: Center(
        child: Container(
          width: currentSize,
          height: currentSize,
          color: Colors.teal,
          child: Center(child: Text(currentSize.toStringAsFixed(1))),
        ),
      ),
    );
  }
}
