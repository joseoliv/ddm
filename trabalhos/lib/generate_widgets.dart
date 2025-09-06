import 'dart:io';

void main() {
  final widgetsDir = Directory('widgets');
  if (!widgetsDir.existsSync()) {
    widgetsDir.createSync(recursive: true);
    print('Created directory: ${widgetsDir.path}');
  }

  final List<String> options = [
    "Container",
    "Text",
    "Row",
    "Column",
    "Icon",
    "Image",
    "NetworkImage",
    "I/O",
    "Load asset image",
    "Load asset text",
    "Save to SP",
    "RichText",
    "DefaultTextStyle",
    "SelectableText",
    "Re_editor",
    "ListView",
    "Align",
    "Padding",
    "MediaQuery",
    "Wrap",
    "OrientationBuilder",
    "LayoutBuilder",
    "FractionallySizedBox",
    "TextField",
    "Form",
    "TextButton",
    "OutlinedButton",
    "IconButton",
    "SegmentedButton",
    "Chip",
    "DropdownMenu",
    "Checkbox",
    "Switch",
    "Radio",
    "DatePickerDialog",
    "TimePickerDialog",
    "InkWell",
    "GestureDetector",
    "Stack and Positioned",
  ];

  for (var option in options) {
    final className = 'W${option.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')}';
    final fileName =
        'w_${option.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_')}.dart';
    final filePath = '${widgetsDir.path}/$fileName';

    final buffer = StringBuffer();
    buffer.writeln("import 'package:flutter/material.dart';\n");
    buffer.writeln("");
    buffer.writeln("class $className extends StatelessWidget {");
    buffer.writeln("  const $className({super.key});\n");
    buffer.writeln("  @override");
    buffer.writeln("  Widget build(BuildContext context) {");
    buffer.writeln("    return Center(");
    buffer.writeln("      child: Text('This is a $option widget')");
    buffer.writeln("    );");
    buffer.writeln("  }");
    buffer.writeln("}\n");

    final file = File(filePath);
    file.createSync();
    file.writeAsStringSync(buffer.toString());

    print('Generated: $filePath');
  }

  print('\n✅ All widget files generated successfully in ${widgetsDir.path}/');
}
