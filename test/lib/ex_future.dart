import 'package:flutter/material.dart';

Future<String> firstFuture() async {
  await Future.delayed(Duration(seconds: 2));
  return 'First Future Completed';
}

Future<void> mainFuture() async {
  countSeconds(4);
  var result = await firstFuture();
  debugPrint(result);
}



void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => debugPrint(i.toString()));
  }
}