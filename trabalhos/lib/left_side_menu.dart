import 'package:flutter/material.dart';
import 'right_side_widget.dart';

class LeftSideMenu extends StatelessWidget {
  final String? sourceCodeFolder;
  final List<String> options = const [
    "Container", "Text", "Row", "Column", "Icon", "Image", "NetworkImage", "I/O",
    "Load asset image", "Load asset text", "Save to SP", "RichText", "DefaultTextStyle",
    "SelectableText", "Re_editor", "ListView", "Align", "Padding", "MediaQuery",
    "Wrap", "OrientationBuilder", "LayoutBuilder", "FractionallySizedBox",
    "TextField", "Form", "TextButton", "OutlinedButton", "IconButton",
    "SegmentedButton", "Chip", "DropdownMenu", "Checkbox", "Switch", "Radio",
    "DatePickerDialog", "TimePickerDialog", "InkWell", "GestureDetector",
    "Stack and Positioned"
  ];

  LeftSideMenu({this.sourceCodeFolder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return ListTile(
            title: Text(option),
            onTap: () {
              RightSideWidgetState? state = context.findAncestorStateOfType<RightSideWidgetState>();
              if (state != null) {
                state.changeWidget(option);
              }
            },
          );
        },
      ),
    );
  }
}