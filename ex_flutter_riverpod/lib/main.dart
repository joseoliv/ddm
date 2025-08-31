import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

/// a provider for int _counter = 0;
final counterProvider = StateProvider<int>((ref) {
  return 0;
});

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  /// a centralized menu with two buttons. One to navigate to HPUsingStateProvider
  /// and the other to HPNotifierProvider
  @override
  /// a centralized menu with two buttons. One to navigate to HPUsingStateProvider
  /// and the other to HPNotifierProvider
  State<MyHomePage> createState() => _MyHomePageState();
}

/// a centralized menu with two buttons. One to navigate to HPUsingStateProvider
/// and the other to HPNotifierProvider
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /// a centralized menu with two buttons. One to navigate to HPUsingStateProvider
    /// and the other to HPNotifierProvider
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod State Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HPUsingStateProvider(
                      title: 'Using StateProvider',
                    ),
                  ),
                );
              },
              child: const Text('Using StateProvider'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HPNotifierProvider(
                      title: 'Using NotifierProvider',
                    ),
                  ),
                );
              },
              child: const Text('Using NotifierProvider'),
            ),
          ],
        ),
      ),
    );
  }
}

class HPUsingStateProvider extends ConsumerStatefulWidget {
  const HPUsingStateProvider({super.key, required this.title});
  final String title;

  @override
  ConsumerState<HPUsingStateProvider> createState() =>
      _HPUsingStateProviderState();
}

class _HPUsingStateProviderState extends ConsumerState<HPUsingStateProvider> {
  void _incrementCounter() {
    /// increment counter
    ref.read(counterProvider.notifier).state++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (context, ref, child) {
                final counter = ref.watch(counterProvider);
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                final counter = ref.read(counterProvider);
                //final counter = ref.watch(counterProvider);
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 1. Define the Notifier class for more complex logic.
class Counter extends Notifier<int> {
  @override
  int build() => 0; // The initial state

  void increment() {
    state++;
  }
}

// 2. Create the provider.
final counterNotProvider = NotifierProvider<Counter, int>(Counter.new);

class HPNotifierProvider extends ConsumerStatefulWidget {
  const HPNotifierProvider({super.key, required this.title});
  final String title;

  @override
  ConsumerState<HPNotifierProvider> createState() => _HPNotifierProviderState();
}

class _HPNotifierProviderState extends ConsumerState<HPNotifierProvider> {
  void _incrementCounter() {
    /// increment counter
    ref.read(counterNotProvider.notifier).increment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (context, ref, child) {
                final counter = ref.watch(counterNotProvider);
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                final counter = ref.read(counterNotProvider);
                //final counter = ref.watch(counterNotProvider);
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
