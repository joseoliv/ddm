import 'package:flutter/material.dart';

class WFirst extends StatelessWidget {
  final String title;
  final Color color;

  const WFirst({
    super.key,
    this.title = 'Default First Widget',
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: color,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class WSecond extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const WSecond({
    super.key,
    this.text = 'Click Me!',
    this.icon = Icons.star,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: const TextStyle(fontSize: 18),
      ),
    );
  }
}
