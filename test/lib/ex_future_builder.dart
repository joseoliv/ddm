import 'dart:convert';
//import 'dart:io';
//import 'dart:isolate';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

Future<dynamic> loadJson(String filename) async {
  // a random number between 1 and 100
  int randomNumber =
      (1 + (100 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000))
          .toInt();

  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$randomNumber'),
  );
  final String jsonPlace = response.body;

  debugPrint(jsonPlace);
  Future.delayed(const Duration(seconds: 2), () {
    debugPrint('After 2 seconds delay');
  });

  //File f = File(filename);

  //final String jsonStr = await f.readAsString();
  // Use Isolate.run to perform heavy parsing in the background.
  // final json = await Isolate.run(() {
  //   final jsonObj = jsonDecode(jsonPlace);
  //   return jsonObj;
  // });

  final jsonObj = jsonDecode(jsonPlace);

  return jsonObj;
}

class ReadShowJsonFutureRiverpod extends StatefulWidget {
  const ReadShowJsonFutureRiverpod({super.key});

  @override
  State<ReadShowJsonFutureRiverpod> createState() => _ReadShowJsonFutureRiverpodState();
}

class _ReadShowJsonFutureRiverpodState extends State<ReadShowJsonFutureRiverpod> {
  Future<dynamic>? readJson;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              readJson = loadJson('MemberList.json');
            });
          },
          child: const Text('Load Json'),
        ),
        SizedBox(height: 40),
        FutureBuilder<dynamic>(
          future: readJson,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: 300,
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return SizedBox(
                width: 300,
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  margin: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Error loading JSON: ${snapshot.error}'),
                    ),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) return const SizedBox.shrink();

            return SizedBox(
              width: 300,
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data.toString()),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class AppIsolateTest extends StatefulWidget {
  const AppIsolateTest({super.key});

  @override
  State<AppIsolateTest> createState() => _AppIsolateTestState();
}

class _AppIsolateTestState extends State<AppIsolateTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Isolate Test')),
        body: const Center(child: ReadShowJsonFutureRiverpod()),
      ),
    );
  }
}
