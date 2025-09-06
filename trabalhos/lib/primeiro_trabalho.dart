import 'package:flutter/material.dart';
import 'left_side_widget.dart';
import 'right_side_widget.dart';
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

class PrimeiroTrabalho extends StatefulWidget {
  const PrimeiroTrabalho({super.key});

  @override
  State<PrimeiroTrabalho> createState() => _PrimeiroTrabalhoState();
}

class _PrimeiroTrabalhoState extends State<PrimeiroTrabalho> {
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
    "Wrap": WWrap.new,
    "TextField": WTextField.new,
    "TextButton": WTextButton.new,
    "OutlinedButton": WOutlinedButton.new,
    "IconButton": WIconButton.new,
    "Checkbox": WCheckbox.new,
    "Switch": WSwitch.new,
    "Radio": WRadio.new,
    "DatePickerDialog": WDatePickerDialog.new,
    "TimePickerDialog": WTimePickerDialog.new,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primeiro trabalho'),
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
