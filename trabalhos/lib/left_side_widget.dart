import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'left_side_menu.dart';

String? sourceCodeFolder;

class LeftSideWidget extends StatefulWidget {
  final Map<String, Widget Function()> widgetMap;

  const LeftSideWidget(this.widgetMap, {super.key});

  @override
  State<LeftSideWidget> createState() => LeftSideWidgetState();
}

class LeftSideWidgetState extends State<LeftSideWidget> {
  void pickFolder() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      setState(() {
        sourceCodeFolder = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              /// rounded with circle 20
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              /// light orange background
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            ),
            onPressed: pickFolder,
            child: const Text("Source code folder"),
          ),
          const SizedBox(height: 10),
          Expanded(child: LeftSideMenu(widget.widgetMap)),
        ],
      ),
    );
  }
}
