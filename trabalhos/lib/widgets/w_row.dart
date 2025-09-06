import 'package:flutter/material.dart';

/// create a stateless widget that just show an image
class WRow extends StatelessWidget {
  const WRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is a Row widget')
    );
  }
}

