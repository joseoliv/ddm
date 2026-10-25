import 'package:flutter/material.dart';

/// O RotationTransition cria rotações explicitamente controladas para qualquer widget.
/// Diferente de transformar o ângulo com TweenAnimationBuilder, este widget utiliza turnos fracionados (turns).
/// Um valor de 1.0 significa uma rotação completa de 360 graus.
/// É incrivelmente eficiente, pois aplica as transformações diretamente na camada gráfica do Flutter.
class RotationTransitionDemo extends StatefulWidget {
  const RotationTransitionDemo({super.key});
  @override
  State<RotationTransitionDemo> createState() => _RotationTransitionDemoState();
}

class _RotationTransitionDemoState extends State<RotationTransitionDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Duração dita a velocidade de um ciclo completo
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
      appBar: AppBar(title: const Text('RotationTransition')),
      body: Center(
        child: RotationTransition(
          turns: _controller, // Vincula o progresso de turnos ao controlador
          child: const FlutterLogo(size: 150),
        ),
      ),
    );
  }
}
