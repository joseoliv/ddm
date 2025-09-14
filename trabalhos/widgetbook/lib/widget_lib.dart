import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:trabalhos/widgets/w_image.dart';
import 'package:trabalhos/widgets/w_align.dart';

@widgetbook.UseCase(name: 'My image', type: WImage)
Widget buildWImageUseCase(BuildContext context) {
  return WImage();
}

@widgetbook.UseCase(name: 'My image loading', type: WImage)
Widget buildWImageUseCaseLoading(BuildContext context) {
  return WImage();
}

@widgetbook.UseCase(name: 'Another', type: WAlign, path: 'layout/align')
Widget buildWAlignUseCase(BuildContext context) {
  return WAlign();
}
