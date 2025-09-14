import 'package:flutter/material.dart';

class WRadio extends StatelessWidget {
  const WRadio({
    required String value,
    required String groupValue,
    required void Function(String?) onChanged,
    Key? key,
  }) : _value = value,
       _groupValue = groupValue,
       _onChanged = onChanged,
       super(key: key);

  final String _value;
  final String _groupValue;
  final void Function(String?) _onChanged;

  @override
  Widget build(BuildContext context) {
    /// Replace with your Radio widget implementation
    return Radio(value: _value, groupValue: _groupValue, onChanged: _onChanged);
  }
}
