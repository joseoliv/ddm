import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:re_editor/re_editor.dart';

import 'package:re_highlight/languages/dart.dart'; // Import the Dart language mode
import 'package:re_highlight/styles/atom-one-light.dart'; // Or any other theme you prefer

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
  CodeLineEditingController? controller;

  @override
  void initState() {
    super.initState();
    controller = CodeLineEditingController();
    currentWidget = Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: const Text("Select an option from the left"),
    );
  }

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
    controller?.text = code;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: SizedBox(
          width: double.infinity,
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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CodeEditor(
                    controller: controller!,
                    readOnly: true,
                    style: CodeEditorStyle(
                      codeTheme: CodeHighlightTheme(
                        languages: {
                          'dart': CodeHighlightThemeMode(mode: langDart),
                        },
                        theme: atomOneLightTheme,
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
