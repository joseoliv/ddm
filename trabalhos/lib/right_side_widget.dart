import 'package:flutter/material.dart';
import 'show_widget.dart';
import 'left_side_widget.dart';

class RightSideWidget extends StatefulWidget {
  const RightSideWidget({super.key});

  @override
  State<RightSideWidget> createState() => RightSideWidgetState();
}

class RightSideWidgetState extends State<RightSideWidget> {
  String? sourceCodeFolder;
  String selectedOption = "Container"; // default
  late Widget currentWidget;

  @override
  void initState() {
    super.initState();
    currentWidget = Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: const Text("Select an option from the left"),
    );
  }

  void changeWidget(String option) {
    setState(() {
      selectedOption = option;
      currentWidget = _buildWidgetForOption(option);
    });
  }

  Widget _buildWidgetForOption(String option) {
    final fileName = 'w_${option.toLowerCase().replaceAll(' ', '_')}.dart';
    // In real app, this would load actual widget from file
    // For now, we just return a placeholder
    return Center(
      child: Text(
        'Widget for: $option\nFile: $fileName',
        textAlign: TextAlign.center,
      ),
    );
  }

  void showCode(BuildContext context) {
    final state = context.findAncestorStateOfType<LeftSideWidgetState>();
    final folder = state?.sourceCodeFolder;
    if (folder == null) {
      _showErrorDialog(context, 'Source code folder not selected.');
      return;
    }
    if (selectedOption.isEmpty) {
      _showErrorDialog(context, 'No option selected.');
      return;
    }

    final fileName = 'w_${selectedOption.toLowerCase().replaceAll(' ', '_')}.dart';
    final fullPath = '$folder/$fileName';

    // Simulate reading the file content (in real app use `dart:io`)
    final code = '''
// Example content of $fullPath
import 'package:flutter/material.dart';

/// create a stateless widget that just show an image
class W${selectedOption.replaceAll(' ', '')} extends StatelessWidget {
  const W${selectedOption.replaceAll(' ', '')}({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
         /// $selectedOption widget
    );
  }
}
    ''';

    _showCodeDialog(context, code, fileName);
  }

  void _showErrorDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCodeDialog(BuildContext context, String code, String title) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: SizedBox(
          width: 600,
          height: 600,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SelectableText(
                      code,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => showCode(context),
            child: const Text("Show code"),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ShowWidget(child: currentWidget),
          ),
        ],
      ),
    );
  }
}