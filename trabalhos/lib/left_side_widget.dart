import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'left_side_menu.dart';

String? sourceCodeFolder;

class LeftSideWidget extends StatefulWidget {
  const LeftSideWidget({super.key});

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
            onPressed: pickFolder,
            child: const Text("Source code"),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: LeftSideMenu(
            ),
          ),
        ],
      ),
    );
  }
}