import 'package:flutter/material.dart';
import 'primeiro_widgets.dart';

void main() {
  runApp(const TrabalhosApp());
}

class TrabalhosApp extends StatelessWidget {
  const TrabalhosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalhos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trabalhos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrimeiroWidgets()),
                );
              },
              child: const Text('Primeiro'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrimeiroWidgets()),
                );
              },
              child: const Text('Segundo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: null,
              child: const Text('Terceiro'),
            ),
          ],
        ),
      ),
    );
  }
}