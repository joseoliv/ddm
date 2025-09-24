import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: directories,
      addons: [
        ViewportAddon(Viewports.all),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
            WidgetbookTheme(
              name: 'Tea',
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF8B4513), // Brown tea color
                  brightness: Brightness.light,
                ),
                primaryColor: const Color(0xFF8B4513),
                scaffoldBackgroundColor: const Color(
                  0xFFF5E6D3,
                ), // Light tea/cream color
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF8B4513),
                  foregroundColor: Colors.white,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B4513),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            WidgetbookTheme(
              name: 'Purple',
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.purpleAccent, // Purple color
                  brightness: Brightness.light,
                ),
              ),
            ),
          ],
        ),
        InspectorAddon(),
        GridAddon(20),
        AlignmentAddon(),
        TextScaleAddon(),
        // TimeDilationAddon(), // only in very specific cases
        ZoomAddon(),

        /// in the future, use https://docs.widgetbook.io/addons/localization-addon
      ],
    );
  }
}
