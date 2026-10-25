import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class IconItem {
  final IconData icon;
  final Color color;
  final String name;

  const IconItem(this.icon, this.color, this.name);
}

const List<IconItem> iconItems = [
  IconItem(Icons.star, Colors.amber, 'Star'),
  IconItem(Icons.favorite, Colors.red, 'Favorite'),
  IconItem(Icons.home, Colors.blue, 'Home'),
  IconItem(Icons.pets, Colors.brown, 'Pets'),
  IconItem(Icons.cloud, Colors.teal, 'Cloud'),
  IconItem(Icons.music_note, Colors.purple, 'Music'),
];

const double homeScale = 1;
const double detailScale = 12;
const double cellSize = 24 * homeScale;
const double gridSpacing = 16;
const int gridColumns = 2;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero icons')),
      body: Center(
        child: SizedBox(
          width: gridColumns * cellSize + (gridColumns - 1) * gridSpacing,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: gridColumns,
            mainAxisSpacing: gridSpacing,
            crossAxisSpacing: gridSpacing,
            children: [
              for (final item in iconItems)
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => DetailPage(item: item)),
                  ),
                  child: Hero(
                    tag: item.name,
                    child: Transform.scale(
                      scale: homeScale,
                      child: Icon(item.icon, color: item.color),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final IconItem item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: SizedBox.expand(
          child: Hero(
            tag: item.name,
            child: Center(
              child: Transform.scale(
                scale: detailScale,
                child: Icon(item.icon, color: item.color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
