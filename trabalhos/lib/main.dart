import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trabalhos/right_side_widget.dart';
import 'package:trabalhos/segundo_trabalho.dart';
import 'package:trabalhos/terceiro_trabalho.dart';
import 'primeiro_trabalho.dart';

var teaColor = createMaterialColor(Color(0xFFC2B280)); // a soft tea brown

var otherColor = createMaterialColor(
  Color.fromARGB(255, 232, 44, 15),
); // a soft tea brown

/// create tea color as materialcolor
///
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = (color.r * 255.0).round() & 0xff;
  final int g = (color.g * 255.0).round() & 0xff;
  final int b = (color.b * 255.0).round() & 0xff;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.toARGB32(), swatch);
}

void main() {
  runApp(ProviderScope(child: TrabalhosApp()));
}

class TrabalhosApp extends StatelessWidget {
  const TrabalhosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalhos',
      debugShowCheckedModeBanner: false,

      /// use a tea color as the primarySwatch color
      theme: ThemeData(colorSchemeSeed: teaColor),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    PrimeiroTrabalho(),
    SegundoTrabalho(),
    TerceiroTrabalho(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      ref.read(selectedOptionProvider.notifier).state = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trabalhos')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: 'Primeiro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: 'Segundo',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: 'Terceiro'),
        ],
      ),
    );
  }
}
