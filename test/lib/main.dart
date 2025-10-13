import 'package:flutter/material.dart';
import 'package:test/traducoes/loc.dart';

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
              Row(
                children: [
                  Text(
                    Translate.getTranslation.home,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                ],
              ),
              Row(
                children: [
                  Text(
                    Translate.getTranslation.search,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ],
              ),
              Row(
                children: [
                  Text(
                    Translate.getTranslation.settings,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                ],
              ),
            ],
          ),
        ),
        body: Center(
          child:
              /// Use layout builder to get the constraints
              /// and change the color of the container based on the width
              /// menu with portuguese, english, french
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Translate.getTranslation.appTitle,
                          style: TextStyle(fontSize: 32, color: _color),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Translate.getTranslation =
                                  Translate.getTranslationFromLocale('pt');
                            });
                          },
                          child: Text('Português'),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Translate.getTranslation =
                                  Translate.getTranslationFromLocale('en');
                            });
                          },
                          child: Text('English'),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Translate.getTranslation =
                                  Translate.getTranslationFromLocale('fr');
                            });
                          },
                          child: Text('Français'),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Translate.getTranslation.appTitle,
                          style: TextStyle(fontSize: 32, color: _color),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Translate.getTranslation =
                                  Translate.getTranslationFromLocale('pt');
                            });
                          },
                          child: Text('Português'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Translate.getTranslation =
                                  Translate.getTranslationFromLocale('en');
                            });
                          },
                          child: Text('English'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Translate.getTranslation =
                                  Translate.getTranslationFromLocale('fr');
                            });
                          },
                          child: Text('Français'),
                        ),
                      ],
                    );
                  }
                },
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
