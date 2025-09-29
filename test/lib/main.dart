import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Color _color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    /// use LayoutBuilder to get the constraints

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          /// icons home, search, settings
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.home)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: Center(
          child:
              /// Use layout builder to get the constraints
              /// and change the color of the container based on the width
              Stack(
                children: [
                  /// positioned container of size 100x100 at top left
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 50,
                    child: Container(
                      width: 300,
                      height: 300,
                      color: const Color.fromARGB(255, 98, 54, 244),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

// This example shows how *not* to write asynchronous Dart code.

String createOrderMessage() {
  var order = fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is more complex and slow.
    Future.delayed(const Duration(seconds: 2), () => 'Large Latte');

void main2() {
  print(createOrderMessage());
}
