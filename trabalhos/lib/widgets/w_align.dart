import 'package:flutter/material.dart';

/// create a stateless widget that just show an image
class WAlign extends StatefulWidget {
  const WAlign({super.key});

  @override
  State<WAlign> createState() => _WAlignState();
}

class _WAlignState extends State<WAlign> {
  AlignmentGeometry ag = Alignment.center;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// A demonstration of the align object. Put buttons to show how
          /// the Align widget works.
          SizedBox(
            width: 300,
            child: Align(
              alignment: ag,
              child: Text('This is the Align Widget'),
            ),
          ),
          SizedBox(height: 40),
          Row(
            /// Three elevated buttons
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ag = Alignment.centerLeft;
                  setState(() {});
                },
                child: Text('Left '),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  ag = Alignment.center;
                  setState(() {});
                },
                child: Text('Center'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  ag = Alignment.centerRight;
                  setState(() {});
                },
                child: Text('Right'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
