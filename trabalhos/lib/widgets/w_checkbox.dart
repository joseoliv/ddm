import 'package:flutter/material.dart';

class WCheckbox extends StatefulWidget {
  const WCheckbox({super.key});

  @override
  State<WCheckbox> createState() => _WCheckboxState();
}

class _WCheckboxState extends State<WCheckbox> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Checkbox(
                value: selectedOption == 'one',
                onChanged: (bool? value) {
                  setState(() {
                    selectedOption = value == true ? 'one' : null;
                  });
                },
              ),
              const Text('one'),
            ],
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              Checkbox(
                value: selectedOption == 'two',
                onChanged: (bool? value) {
                  setState(() {
                    selectedOption = value == true ? 'two' : null;
                  });
                },
              ),
              const Text('two'),
            ],
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              Checkbox(
                value: selectedOption == 'three',
                onChanged: (bool? value) {
                  setState(() {
                    selectedOption = value == true ? 'three' : null;
                  });
                },
              ),
              const Text('three'),
            ],
          ),
        ],
      ),
    );
  }
}
