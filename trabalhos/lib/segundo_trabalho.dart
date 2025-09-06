import 'package:flutter/material.dart';
import 'left_side_widget.dart';
import 'right_side_widget.dart';
import 'package:trabalhos/widgets/w_chip.dart';
import 'package:trabalhos/widgets/w_defaulttextstyle.dart';
import 'package:trabalhos/widgets/w_dropdownmenu.dart';
import 'package:trabalhos/widgets/w_form.dart';
import 'package:trabalhos/widgets/w_fractionallysizedbox.dart';
import 'package:trabalhos/widgets/w_gesturedetector.dart';
import 'package:trabalhos/widgets/w_inkwell.dart';
import 'package:trabalhos/widgets/w_layoutbuilder.dart';
import 'package:trabalhos/widgets/w_mediaquery.dart';
import 'package:trabalhos/widgets/w_orientationbuilder.dart';
import 'package:trabalhos/widgets/w_segmentedbutton.dart';
import 'package:trabalhos/widgets/w_stack_and_positioned.dart';

class SegundoTrabalho extends StatefulWidget {
  const SegundoTrabalho({super.key});

  @override
  State<SegundoTrabalho> createState() => _SegundoTrabalhoState();
}

class _SegundoTrabalhoState extends State<SegundoTrabalho> {
  final Map<String, Widget Function()> widgetMap = {
    "MediaQuery": WMediaQuery.new,
    "OrientationBuilder": WOrientationBuilder.new,
    "LayoutBuilder": WLayoutBuilder.new,
    "FractionallySizedBox": WFractionallySizedBox.new,
    "Form": WForm.new,
    "SegmentedButton": WSegmentedButton.new,
    "DropdownMenu": WDropdownMenu.new,
    "InkWell": WInkWell.new,
    "GestureDetector": WGestureDetector.new,
    "Stack and Positioned": WStackandPositioned.new,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segundo trabalho'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        children: [
          Expanded(flex: 1, child: LeftSideWidget(widgetMap)),
          Expanded(flex: 2, child: RightSideWidget()),
        ],
      ),
    );
  }
}
