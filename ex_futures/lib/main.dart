import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// use Flutter Riverpod for state management to keep the file name
final fileNameProvider = StateProvider<String>((ref) => '');

void main() {
  runApp(ProviderScope(child: FutureExampleApp()));
}

/// Loads a file from assets and returns its content as a String.
Future<String> loadFile(String path) async {
  try {
    await Future.delayed(const Duration(seconds: 2));
    return await rootBundle.loadString(path);
  } catch (e) {
    throw Exception('Failed to load file: $e');
  }
}

/// Create class MyApp that reads a file name, loads it asynchronously, and displays the content in a Text widget.
/// While the file is loading, display a CircularProgressIndicator.
class FutureExampleApp extends ConsumerStatefulWidget {
  const FutureExampleApp({super.key});

  @override
  ConsumerState<FutureExampleApp> createState() => _FutureExampleAppState();
}

class _FutureExampleAppState extends ConsumerState<FutureExampleApp> {
  final TextEditingController _controllerFilename = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('File Loader with FutureBuilder')),
        body: Center(
          child: SizedBox(
            width: 600,
            height: 500,
            child: Column(
              children: [
                TextField(
                  controller: _controllerFilename,
                  decoration: const InputDecoration(
                    labelText: 'Enter file name',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    // change fileNameProvider with the new value
                    ref.read(fileNameProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 30),
                Builder(
                  builder: (context) {
                    var name = ref.watch(fileNameProvider);
                    return name.isEmpty
                        ? const Text('Please enter a file name above')
                        : FutureBuilder<String>(
                            future: loadFile('assets/$name'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                return Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      'File content: ${snapshot.data}',
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// just a function to demonstrate Future usage
Future<String> loadFileExample() {
  try {
    return loadFile('assets/text.txt');
    // ignore: empty_catches
  } catch (e) {}
  return Future<String>.value('');
}

/// another example with then and catchError
void loadFileExample2() {
  loadFile('assets/text.txt')
      .then(
        (content) {
          print('File content: $content');
        },
        onError: (error) {
          print('Error loading file: $error');
        },
      )
      .catchError((error) {
        /// melhor
        print('Error loading file: $error');
      });
}

Future<dynamic> loadJson(String filename) async {
  File f = File(filename);

  // Use Isolate.run to perform heavy parsing in the background.
  final json = await Isolate.run(  () async {
    final String jsonStr = await f.readAsString();
    final jsonObj = jsonDecode(jsonStr);
    return jsonObj;
  });
  return json;
}
