import 'package:flutter/material.dart';

/// create a stateless widget that just show an image
class WTextButton extends StatelessWidget {
  const WTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is a TextButton widget')
    );
  }
}

