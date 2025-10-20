import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de exemplo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const MyHomePage(title: 'App de exemplo'),
    );
  }
}

enum ItemType { button, icon, blueContainer, triangle, redSquare, chip }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ItemType> leftItems = [];
  List<ItemType> rightItems = [];
  Offset? _offset;

  @override
  void initState() {
    super.initState();
    leftItems = [
      ItemType.button,
      ItemType.icon,
      ItemType.blueContainer,
      ItemType.triangle,
      ItemType.redSquare,
      ItemType.chip,
    ];
  }

  Widget _buildDraggableItem(ItemType type) {
    Widget child = _buildWidget(type);

    return Draggable<ItemType>(
      data: type,

      /// o widget sendo arrastado pela tela
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(opacity: 0.5, child: _buildWidget(type)),
      ),

      /// o widget que fica fixo no lugar original quando está sendo arrastado
      childWhenDragging: Opacity(opacity: 0.2, child: child),

      /// o widget original
      child: child,
    );
  }

  Widget _buildWidget(ItemType type) {
    switch (type) {
      case ItemType.button:
        return ElevatedButton(onPressed: () {}, child: const Text('Move me'));
      case ItemType.icon:
        return const Icon(Icons.emoji_emotions, size: 50, color: Colors.amber);
      case ItemType.blueContainer:
        return Container(width: 100, height: 50, color: Colors.blue);
      case ItemType.triangle:
        return CustomPaint(
          size: const Size(70, 70),
          painter: TrianglePainter(),
        );
      case ItemType.redSquare:
        return Container(width: 80, height: 80, color: Colors.red);
      case ItemType.chip:
        return const Chip(
          avatar: Icon(Icons.star, size: 16),
          label: Text('Chip'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
              /// left drag target
              child: DragTarget<ItemType>(
                onAcceptWithDetails: (details) {
                  setState(() {
                    if (!leftItems.contains(details.data)) {
                      rightItems.remove(details.data);
                      leftItems.add(details.data);
                    }
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    constraints: const BoxConstraints(
                      minHeight: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: leftItems
                            .map((item) => _buildDraggableItem(item))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              /// right drag target
              child: DragTarget<ItemType>(
                onAcceptWithDetails: (details) {
                  setState(() {
                    if (!rightItems.contains(details.data)) {
                      leftItems.remove(details.data);
                      rightItems.add(details.data);
                    }
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    constraints: const BoxConstraints(
                      minHeight: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: rightItems
                            .map((item) => _buildDraggableItem(item))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
