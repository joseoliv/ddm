import 'package:flutter/material.dart';
import 'package:trabalhos/widgets/w_radio.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:trabalhos/widgets/w_image.dart';
import 'package:trabalhos/widgets/w_align.dart';
import 'package:widgetbook_workspace/radio_list_tile.dart';

/// in the terminal, run:
/// dart run build_runner watch

@widgetbook.UseCase(name: 'Image', type: WImage)
Widget buildWImageUseCase(BuildContext context) {
  return WImage();
}

@widgetbook.UseCase(name: 'Fake image loading', type: WImage)
Widget buildWImageUseCaseLoading(BuildContext context) {
  return WImage();
}

@widgetbook.UseCase(name: 'Another', type: WAlign, path: 'layout/align')
Widget buildWAlignUseCase(BuildContext context) {
  return WAlign();
}

@widgetbook.UseCase(name: 'Another', type: WRadio, path: 'radio')
Widget buildWRadioUseCase(BuildContext context) {
  // group several radio buttons together
  String groupValue = 'groupValue';
  String value = 'value';

  return WRadio(value: value, groupValue: groupValue, onChanged: (value) {});
}

// A Widgetbook UseCase that showcases the WRadioButtonGroup widget.
// The @widgetbook.UseCase annotation is used to register this with Widgetbook.
@widgetbook.UseCase(
  name: 'Radio Button Group',
  type: WRadioButtonGroup,
  path: 'radio',
)
Widget buildRadioButtonUseCase(BuildContext context) {
  return const WRadioButtonGroup();
}

@widgetbook.UseCase(name: 'Container', type: Container)
Widget buildWContainerUseCase(BuildContext context) {
  return Container(width: 100, height: 100, color: Colors.blue);
}
