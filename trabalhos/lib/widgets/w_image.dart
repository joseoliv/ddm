import 'package:flutter/material.dart';

/// create a stateless widget that just show an image
class WImage extends StatelessWidget {
  const WImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/ellen-volkova-qDoX7E9G7fY-unsplash.jpg',
      ),
    );
  }
}
