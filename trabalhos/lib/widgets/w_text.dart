import 'package:flutter/material.dart';

/// create a stateless widget that just show an image
class WText extends StatelessWidget {
  const WText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is a Text widget')
    );
  }
}

