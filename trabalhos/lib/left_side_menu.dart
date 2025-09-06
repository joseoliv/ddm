import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'right_side_widget.dart';

class LeftSideMenu extends StatelessWidget {

  final Map<String, Widget Function()> widgetMap;

  const LeftSideMenu(this.widgetMap, {super.key});

  @override
  Widget build(BuildContext context) {
    /// transform widgetMap into a list of options. Each element has type
    /// (String, Widget Function())
    final options = widgetMap.entries.toList();

    /// sort according to the widget name
    options.sort((a, b) => a.key.compareTo(b.key));

    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Consumer(
            builder: (context, ref, child) {
              return ListTile(
                title: Text(option.key),
                onTap: () {
                  ref.read(selectedOptionProvider.notifier).state = (
                    option.key,
                    option.value,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
