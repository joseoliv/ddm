import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(), debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Problematic usage: NO KEY provided
            ProblematicWidget(
              text: _showFirst ? 'First' : 'Second',
              key: ValueKey(_showFirst), // Uncomment this to fix!
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showFirst = !_showFirst;
                });
              },
              child: const Text('Toggle Text'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProblematicWidget extends StatefulWidget {
  // No required key parameter - key is optional
  final String text;

  const ProblematicWidget({
    super.key, // Key is optional (default behavior)
    required this.text,
  });

  @override
  State<ProblematicWidget> createState() => _ProblematicWidgetState();
}

class _ProblematicWidgetState extends State<ProblematicWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Widget Text: ${widget.text}',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 12),
        Text('Counter: $_counter', style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 12),

        ElevatedButton(
          onPressed: () {
            // This setState should update the counter
            // BUT if this widget loses its state due to missing key,
            // the counter will reset to 0
            setState(() {
              _counter++;
            });
          },
          child: const Text(
            'Increment Counter',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
