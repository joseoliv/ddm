import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trabalhos/widgets/w_align.dart';
import 'package:trabalhos/widgets/w_checkbox.dart';
import 'package:trabalhos/widgets/w_chip.dart';
import 'package:trabalhos/widgets/w_column.dart';
import 'package:trabalhos/widgets/w_container.dart';
import 'package:trabalhos/widgets/w_datepickerdialog.dart';
import 'package:trabalhos/widgets/w_defaulttextstyle.dart';
import 'package:trabalhos/widgets/w_dropdownmenu.dart';
import 'package:trabalhos/widgets/w_form.dart';
import 'package:trabalhos/widgets/w_fractionallysizedbox.dart';
import 'package:trabalhos/widgets/w_gesturedetector.dart';
import 'package:trabalhos/widgets/w_i_o.dart';
import 'package:trabalhos/widgets/w_icon.dart';
import 'package:trabalhos/widgets/w_iconbutton.dart';
import 'package:trabalhos/widgets/w_image.dart';
import 'package:trabalhos/widgets/w_inkwell.dart';
import 'package:trabalhos/widgets/w_layoutbuilder.dart';
import 'package:trabalhos/widgets/w_listview.dart';
import 'package:trabalhos/widgets/w_load_asset_image.dart';
import 'package:trabalhos/widgets/w_load_asset_text.dart';
import 'package:trabalhos/widgets/w_mediaquery.dart';
import 'package:trabalhos/widgets/w_networkimage.dart';
import 'package:trabalhos/widgets/w_orientationbuilder.dart';
import 'package:trabalhos/widgets/w_outlinedbutton.dart';
import 'package:trabalhos/widgets/w_padding.dart';
import 'package:trabalhos/widgets/w_radio.dart';
import 'package:trabalhos/widgets/w_re_editor.dart';
import 'package:trabalhos/widgets/w_richtext.dart';
import 'package:trabalhos/widgets/w_row.dart';
import 'package:trabalhos/widgets/w_save_to_sp.dart';
import 'package:trabalhos/widgets/w_segmentedbutton.dart';
import 'package:trabalhos/widgets/w_selectabletext.dart';
import 'package:trabalhos/widgets/w_stack_and_positioned.dart';
import 'package:trabalhos/widgets/w_switch.dart';
import 'package:trabalhos/widgets/w_text.dart';
import 'package:trabalhos/widgets/w_textbutton.dart';
import 'package:trabalhos/widgets/w_textfield.dart';
import 'package:trabalhos/widgets/w_timepickerdialog.dart';
import 'package:trabalhos/widgets/w_wrap.dart';
import 'right_side_widget.dart';

class LeftSideMenu extends StatelessWidget {
  final Map<String, Widget Function()> widgetMap = {
    "Container": WContainer.new,
    "Text": WText.new,
    "Row": WRow.new,
    "Column": WColumn.new,
    "Icon": WIcon.new,
    "Image": WImage.new,
    "NetworkImage": WNetworkImage.new,
    "I/O": WIO.new,
    "Load asset image": WLoadassetimage.new,
    "Load asset text": WLoadassettext.new,
    "Save to SP": WSavetoSP.new,
    "RichText": WRichText.new,
    "DefaultTextStyle": WDefaultTextStyle.new,
    "SelectableText": WSelectableText.new,
    "Re_editor": WReeditor.new,
    "ListView": WListView.new,
    "Align": WAlign.new,
    "Padding": WPadding.new,
    "MediaQuery": WMediaQuery.new,
    "Wrap": WWrap.new,
    "OrientationBuilder": WOrientationBuilder.new,
    "LayoutBuilder": WLayoutBuilder.new,
    "FractionallySizedBox": WFractionallySizedBox.new,
    "TextField": WTextField.new,
    "Form": WForm.new,
    "TextButton": WTextButton.new,
    "OutlinedButton": WOutlinedButton.new,
    "IconButton": WIconButton.new,
    "SegmentedButton": WSegmentedButton.new,
    "Chip": WChip.new,
    "DropdownMenu": WDropdownMenu.new,
    "Checkbox": WCheckbox.new,
    "Switch": WSwitch.new,
    "Radio": WRadio.new,
    "DatePickerDialog": WDatePickerDialog.new,
    "TimePickerDialog": WTimePickerDialog.new,
    "InkWell": WInkWell.new,
    "GestureDetector": WGestureDetector.new,
    "Stack and Positioned": WStackandPositioned.new,
  };
  LeftSideMenu({super.key});

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
