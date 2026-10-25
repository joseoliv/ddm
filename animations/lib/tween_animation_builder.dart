import 'package:flutter/material.dart';

/// O TweenAnimationBuilder permite criar animações implícitas customizadas sem usar AnimationController.
/// Você fornece um Tween e o Flutter automaticamente interpola os valores e chama o builder.
/// É perfeito para situações em que você só precisa ir de um valor A a B uma vez ou de forma reativa.
/// Economiza muito código em comparação com as animações explícitas tradicionais.
class TweenAnimationBuilderDemo extends StatelessWidget {
  const TweenAnimationBuilderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TweenAnimationBuilder')),
      body: Center(
        // Anima um ângulo de 0 a 2*Pi
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 6.28), // 6.28 é aprox 2*Pi radianos
          duration: const Duration(seconds: 2),
          builder: (BuildContext context, double angle, Widget? child) {
            return Transform.rotate(
              angle: angle, // Aplica o ângulo interpolado atual
              child: Container(width: 150, height: 150, color: Colors.indigo),
            );
          },
        ),
      ),
    );
  }
}
