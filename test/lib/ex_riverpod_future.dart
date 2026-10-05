import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

Future<dynamic> loadJson(String filename) async {
  final randomNumber =
      (1 + (100 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000))
          .toInt();
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$randomNumber'),
  );
  final jsonPlace = response.body;

  Future.delayed(const Duration(seconds: 2), () {
    debugPrint('After 2 seconds delay');
  });

  return jsonDecode(jsonPlace);
}

final jsonProvider = FutureProvider<dynamic>((ref) {
  debugPrint('FutureProvider jsonProvider called');
  return loadJson('MemberList.json');
});

class ReadShowJsonFutureRiverpod extends ConsumerStatefulWidget {
  const ReadShowJsonFutureRiverpod({super.key});

  @override
  ConsumerState<ReadShowJsonFutureRiverpod> createState() => _ReadShowJsonFutureRiverpodState();
}

class _ReadShowJsonFutureRiverpodState extends ConsumerState<ReadShowJsonFutureRiverpod> {
  bool _loadRequested = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ref.invalidate(jsonProvider);
            setState(() {
              _loadRequested = true;
            });
          },
          child: const Text('Load Json'),
        ),
        const SizedBox(height: 40),
        if (_loadRequested)
          ref
              .watch(jsonProvider)
              .when(
                loading: () => const SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) =>
                    _buildJsonBox(Text('Error loading JSON: $error')),
                data: (data) => _buildJsonBox(Text(data.toString())),
              ),
      ],
    );
  }

  Widget _buildJsonBox(Widget content) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        margin: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(8.0), child: content),
        ),
      ),
    );
  }
}

class AppRiverpodFuture extends StatelessWidget {
  const AppRiverpodFuture({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('Riverpod Future Test')),
          body: Center(child: ReadShowJsonFutureRiverpod()),
        ),
      ),
    );
  }
}
