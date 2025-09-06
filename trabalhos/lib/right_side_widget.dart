import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'show_widget.dart';
import 'left_side_widget.dart';

/// use flutter_riverpod to declare a provider for named [selectedOption]
final selectedOptionProvider = StateProvider<(String, Widget Function())?>((
  ref,
) {
  return null;
});

class RightSideWidget extends StatefulWidget {
  const RightSideWidget({super.key});

  @override
  State<RightSideWidget> createState() => RightSideWidgetState();
}

class RightSideWidgetState extends State<RightSideWidget> {
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

  // void changeWidget((String, Widget Function()) option) {
  //   selectedOption = option.$1;
  //   currentWidget = _buildWidgetForOption(option.$2);
  //   setState(() {});
  // }

  // Widget _buildWidgetForOption(Widget Function() builder) {
  //   final fileName =
  //       'w_${selectedOption.toLowerCase().replaceAll(' ', '_')}.dart';
  //   // In real app, this would load actual widget from file
  //   // For now, we just return a placeholder
  //   return Center(child: builder());
  // }

  void showCode(BuildContext context) {
    final selectedOption =
        ProviderScope.containerOf(
          context,
          listen: false,
        ).read(selectedOptionProvider.notifier).state?.$1 ??
        '';
    if (sourceCodeFolder == null) {
      _showErrorDialog(context, 'Source code folder not selected.');
      return;
    }
    if (selectedOption.isEmpty) {
      _showErrorDialog(context, 'No option selected.');
      return;
    }

    final fileName =
        'w_${selectedOption.toLowerCase().replaceAll(' ', '_')}.dart';
    final fullPath = '$sourceCodeFolder/$fileName';

    /// read file fullPath to code
    final code = File(fullPath).readAsStringSync();

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
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
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
          Consumer(
            builder: (context, ref, child) {
              final currentWidget = ref.watch(selectedOptionProvider)?.$2();
              if (currentWidget == null) {
                return const Expanded(
                  child: Center(child: Text("Select an option from the left")),
                );
              } else {
                return Expanded(child: ShowWidget(child: currentWidget));
              }
            },
          ),
        ],
      ),
    );
  }
}
