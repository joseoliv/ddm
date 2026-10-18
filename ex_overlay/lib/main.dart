import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Demonstrates managing a floating widget with Flutter's overlay system.
///
/// An [Overlay] is a stack of entries displayed above the normal widget
/// content. An [OverlayEntry] can be inserted or removed independently of
/// rebuilding this page, which is useful for floating controls, menus, and
/// other transient UI.
class _MyHomePageState extends State<MyHomePage> {
  /// The handle used to insert, rebuild, and remove this page's floating UI.
  OverlayEntry? entry;

  /// The floating control's position, measured from the overlay's top-left.
  Offset offset = Offset(20, 100);

  @override
  void initState() {
    super.initState();
    // An overlay can be shown here after the first frame if it should appear
    // automatically; this example instead waits for the user's button tap.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showOverlay();
    // });
  }

  @override
  void dispose() {
    // Remove the entry before this State goes away so it cannot outlive its
    // owner or keep displaying stale UI.
    hideOverlay();
    super.dispose();
  }

  void showOverlay() {
    // Keep this action idempotent: replace an existing entry rather than
    // stacking another floating button on top of it.
    if (entry != null) {
      entry?.remove();
    }

    // The entry's builder describes what appears in the overlay's own stack.
    // Positioned works here because Overlay lays its entries out like a Stack.
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy,
        left: offset.dx,
        child: GestureDetector(
          onPanUpdate: (details) {
            // Drag deltas update the saved position; markNeedsBuild asks this
            // entry to run its builder again without rebuilding the page.
            offset += details.delta;
            entry!.markNeedsBuild();
          },
          child: ElevatedButton.icon(
            /// ElevatedButton.icon with orange accent color background
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {},
            label: const Text('Floating'),
            icon: Icon(Icons.stop_circle_rounded),
          ),
        ),
      ),
    );

    // Find the nearest Overlay in the current route, then insert the entry so
    // it is painted above the route's regular widget content.
    final overlay = Overlay.of(context);
    overlay.insert(entry!);
  }

  void hideOverlay() {
    // remove() detaches the entry from the overlay; clearing the handle also
    // records that there is no floating control to remove on the next call.
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    // The buttons belong to the normal page tree; they control a separate
    // OverlayEntry, illustrating that overlay content is not a Scaffold child.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: showOverlay,
              child: Text('Show Overlay button'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: hideOverlay,
              child: Text(
                'Hide Overlay button',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(child: Container(height: 50.0)),
    );
  }
}
