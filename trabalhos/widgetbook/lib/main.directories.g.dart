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
    name: 'radio',
    children: [
      _widgetbook.WidgetbookLeafComponent(
        name: 'WRadio',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Another',
          builder: _widgetbook_workspace_widget_lib.buildWRadioUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'WRadioButtonGroup',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Radio Button Group',
          builder: _widgetbook_workspace_widget_lib.buildRadioButtonUseCase,
        ),
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookLeafComponent(
        name: 'Container',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Container',
          builder: _widgetbook_workspace_widget_lib.buildWContainerUseCase,
        ),
      ),
      _widgetbook.WidgetbookComponent(
        name: 'WImage',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Fake image loading',
            builder: _widgetbook_workspace_widget_lib.buildWImageUseCaseLoading,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Image',
            builder: _widgetbook_workspace_widget_lib.buildWImageUseCase,
          ),
        ],
      ),
    ],
  ),
];
