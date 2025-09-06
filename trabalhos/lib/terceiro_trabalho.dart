import 'package:flutter/material.dart';
import 'package:trabalhos/widgets/w_login.dart';
import 'left_side_widget.dart';
import 'right_side_widget.dart';

class TerceiroTrabalho extends StatefulWidget {
  const TerceiroTrabalho({super.key});

  @override
  State<TerceiroTrabalho> createState() => _TerceiroTrabalhoState();
}

class _TerceiroTrabalhoState extends State<TerceiroTrabalho> {
  final Map<String, Widget Function()> widgetMap = {"Login": WLogin.new};

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: LeftSideWidget(widgetMap)),
        Expanded(flex: 2, child: RightSideWidget()),
      ],
    );
  }
}
