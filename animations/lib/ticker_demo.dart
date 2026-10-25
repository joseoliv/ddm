import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'dart:math' as math;

/// O Ticker é a fundação de baixo nível para todas as animações no Flutter.
/// Ele chama um callback a cada frame renderizado pela tela (geralmente 60 ou 120 vezes por segundo).
/// Aqui, não usamos AnimationController; nós mesmos calculamos o tamanho manualmente.
/// Usamos o tempo decorrido para calcular uma onda senoidal, resultando numa animação rítmica.
class TickerDemo extends StatefulWidget {
  const TickerDemo({super.key});
  @override
  State<TickerDemo> createState() => _TickerDemoState();
}

class _TickerDemoState extends State<TickerDemo> {
  Ticker? _ticker;
  double _size = 100.0;

  @override
  void initState() {
    super.initState();
    // Cria o Ticker, recebendo o 'elapsed' (duração desde que começou)
    _ticker = Ticker((Duration elapsed) {
      setState(() {
        // Usa função seno para alternar tamanho entre 100 e 200 de forma cíclica e suave
        _size = 150.0 + 50.0 * math.sin(elapsed.inMilliseconds / 300.0);
      });
    });
    _ticker!.start(); // Inicia o relógio
  }

  @override
  void dispose() {
    _ticker?.dispose(); // Extremamente importante descartar para evitar memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticker (Low Level)')),
      body: Center(
        child: Container(
          width: _size,
          height: _size,
          color: Colors.blue, // A cor permanece igual, apenas mudamos dimensões via Ticker
        ),
      ),
    );
  }
}

