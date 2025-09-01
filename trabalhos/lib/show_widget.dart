import 'package:flutter/material.dart';

class ShowWidget extends StatelessWidget {
  final Widget child;

  const ShowWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}