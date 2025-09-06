import 'package:flutter/material.dart';

/// create a stateless widget that just show an image
class WRichText extends StatelessWidget {
  const WRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is a RichText widget')
    );
  }
}

