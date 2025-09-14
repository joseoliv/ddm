// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_workspace/widget_lib.dart'
    as _widgetbook_workspace_widget_lib;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'layout',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'align',
        children: [
          _widgetbook.WidgetbookLeafComponent(
            name: 'WAlign',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'Another',
              builder: _widgetbook_workspace_widget_lib.buildWAlignUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'WImage',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'My image',
            builder: _widgetbook_workspace_widget_lib.buildWImageUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'My image loading',
            builder: _widgetbook_workspace_widget_lib.buildWImageUseCaseLoading,
          ),
        ],
      ),
    ],
  ),
];
