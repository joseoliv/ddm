import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'dart:math' as math;

class TickerTest extends StatefulWidget {
  const TickerTest({super.key});
  @override
  State<TickerTest> createState() => _TickerTestState();
}

class _TickerTestState extends State<TickerTest> {
  Ticker? _ticker;
  double _size = 100.0;
  int numberOfTicks = 0; // Contador de ticks para depuração
  int numSegundos = 0;

  @override
  void initState() {
    super.initState();
    // Cria o Ticker, recebendo o 'elapsed' (duração desde que começou)
    _ticker = Ticker((Duration elapsed) {
      setState(() {
        // Usa função seno para alternar tamanho entre 100 e 200 de forma cíclica e suave
        numberOfTicks++; // Incrementa o contador de ticks
        numSegundos = (elapsed.inMilliseconds / 1000)
            .floor(); // Converte para segundos
        _size =
            350.0 +
            5.0 * (numSegundos % numberOfTicks); // Alterna entre 100 e 200
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
      appBar: AppBar(title: const Text('Ticker (Test)')),
      body: Center(
        child: Container(
          width: _size,
          height: 200,
          color: Colors.blue, // A cor permanece igual, apenas mudamos dimensões via Ticker
          child: Center(
            child: Text(
              'Num. de Ticks: $numberOfTicks\nNum. de Segundos: $numSegundos\nTiks/segundo: ${(numberOfTicks / (numSegundos == 0 ? 1 : numSegundos)).toStringAsFixed(2)}  ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
