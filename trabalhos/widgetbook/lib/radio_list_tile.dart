import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

// A widget that displays a group of radio buttons inside a Card.
// The options for the radio buttons are configurable using Widgetbook knobs.
class WRadioButtonGroup extends StatefulWidget {
  const WRadioButtonGroup({super.key});

  @override
  State<WRadioButtonGroup> createState() => _WRadioButtonGroupState();
}

class _WRadioButtonGroupState extends State<WRadioButtonGroup> {
  // A variable to hold the currently selected value, initialized to an empty string.
  // This approach avoids nullability issues with groupValue.
  int? _groupValue = 1;

  @override
  Widget build(BuildContext context) {
    // Define the options for the radio buttons using Widgetbook knobs.
    // The user can edit these values in the Widgetbook UI.
    final String option1 = context.knobs.string(
      label: 'Option 1',
      initialValue: 'Banana',
    );
    final String option2 = context.knobs.string(
      label: 'Option 2',
      initialValue: 'Laranja',
    );
    final String option3 = context.knobs.string(
      label: 'Option 3',
      initialValue: 'Manga',
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // Group the radio buttons inside a Card to create a visual "box".
        child: RadioGroup<int>(
          groupValue: _groupValue,
          onChanged: (int? value) {
            setState(() {
              _groupValue = value;
            });
          },
          child: Column(
            children: [
              RadioListTile<int>(title: Text(option1), value: 1),
              RadioListTile<int>(title: Text(option2), value: 2),
              RadioListTile<int>(title: Text(option3), value: 3),
            ],
          ),
        ),
      ),
    );
  }
}
