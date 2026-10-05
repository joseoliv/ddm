import 'package:flutter/material.dart';
import 'package:test/ex_future.dart';
// import 'package:test/ex_isolate.dart';
import 'package:test/ex_riverpod_future.dart';

void main() async {
  Future<void> mainFutureResult = mainFuture();
  mainFutureResult
      .then((_) {
        debugPrint(
          'At main, in the anonymous function after mainFuture() Completed',
        );
      })
      .catchError((error) {
        debugPrint('Error occurred in mainFuture: $error');
      })
      .whenComplete(() {
        debugPrint(
          'At main, in the anonymous function after mainFuture() Completed (whenComplete)',
        );
        debugPrint('At main, after mainFuture() Completed');
      });
  runApp(const AppRiverpodFuture());
}

Future<String> loginUser() async {
  try {
    await Future.delayed(const Duration(seconds: 2));
    return 'User logged in successfully!';
  } catch (error) {
    return 'Error: $error';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(title: const Text('FutureBuilder Widget')),
        body: Center(
          child: FutureBuilder(
            future: loginUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text('No connection');
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                // TODO: Handle this case.
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text('Message: ${snapshot.data}');
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
