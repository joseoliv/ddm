import 'package:flutter/material.dart';

/// O SingleTickerProviderStateMixin é essencial ao trabalhar com AnimationController.
/// Ele fornece um "Ticker" (um relógio de frames) apenas quando esta tela específica estiver visível.
/// Isso evita que animações rodem em segundo plano, economizando bateria e CPU do celular.
/// Adicionamos ele usando 'with' na declaração do State.
class SingleTickerMixinDemo extends StatefulWidget {
  const SingleTickerMixinDemo({super.key});
  @override
  State<SingleTickerMixinDemo> createState() => _SingleTickerMixinDemoState();
}

// Observe a palavra-chave 'with' introduzindo o Mixin
class _SingleTickerMixinDemoState extends State<SingleTickerMixinDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // O parâmetro 'vsync: this' só é possível graças ao Mixin que adicionamos
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose(); // Sempre descarte controladores para evitar vazamentos de memória
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SingleTickerProviderStateMixin')),
      body: const Center(
        child: Text('Veja o código fonte. O mixin habilita o vsync para eficiência!'),
      ),
    );
  }
}
