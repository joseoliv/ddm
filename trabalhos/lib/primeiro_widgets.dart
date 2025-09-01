import 'package:flutter/material.dart';
import 'left_side_widget.dart';
import 'right_side_widget.dart';

class PrimeiroWidgets extends StatefulWidget {
  const PrimeiroWidgets({super.key});

  @override
  State<PrimeiroWidgets> createState() => _PrimeiroWidgetsState();
}

class _PrimeiroWidgetsState extends State<PrimeiroWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primeiro Widgets'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        children: [
          const Expanded(flex: 1, child: LeftSideWidget()),
          Expanded(flex: 2, child: RightSideWidget()),
        ],
      ),
    );
  }
}