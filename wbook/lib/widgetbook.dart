import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'w.dart'; // Import your widgets file

// The @widgetbook.App annotation marks this file as the entry point for Widgetbook.
// It tells the generator where to look for stories.
@widgetbook.App()
class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // The directories property is where you organize your widgets into categories.
      directories: [
        WidgetbookCategory(
          name: 'My Custom Widgets',
          // You can have sub-categories
          children: [
            WidgetbookComponent(
              name: 'WFirst Widget',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default WFirst',
                  builder: (context) => WFirst(
                    // You can use Widgetbook's knobs to make widget properties interactive
                    title: context.knobs.string(
                      label: 'Title',
                      initialValue: 'Hello from WFirst!',
                    ),
                    color: context.knobs.color(
                      label: 'Background Color',
                      initialValue: Colors.blue,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Red WFirst',
                  builder: (context) =>
                      const WFirst(title: 'Red Variant', color: Colors.red),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'WSecond Widget',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default WSecond',
                  builder: (context) => WSecond(
                    text: context.knobs.string(
                      label: 'Button Text',
                      initialValue: 'Press Me!',
                    ),
                    icon: context.knobs.object.dropdown(
                      label: 'Icon',
                      options: [Icons.star, Icons.check, Icons.send],
                      initialOption: Icons.star,
                    ),
                    onPressed: () {
                      // You can add a simple action for the knob
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('WSecond Pressed!')),
                      );
                    },
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Disabled WSecond',
                  builder: (context) => const WSecond(
                    text: 'Disabled',
                    onPressed: null, // No onPressed means disabled
                    icon: Icons.block,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
      // Add a custom theme if you want your Widgetbook to look different
      appBuilder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: child,
        );
      },
    );
  }
}
