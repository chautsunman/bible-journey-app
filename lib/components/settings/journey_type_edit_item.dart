import 'package:bible_journey_app/app_components/app_extensions.dart';
import 'package:bible_journey_app/components/type_color_block.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class JourneyTypeEditItem extends StatefulWidget {
  const JourneyTypeEditItem(
      {Key? key,
      required this.journeyType,
      required this.setJourneyType,
      required this.onSave})
      : super(key: key);

  final JourneyType journeyType;
  final void Function(JourneyType) setJourneyType;
  final void Function() onSave;

  @override
  State<JourneyTypeEditItem> createState() => _JourneyTypeEditItemState();
}

class _JourneyTypeEditItemState extends State<JourneyTypeEditItem> {
  Color color = const Color(0x00000000);

  onTextChange(String text) {
    final newJourneyType = widget.journeyType.clone();
    newJourneyType.type = text;
    widget.setJourneyType(newJourneyType);
  }

  onColorChange(Color color) {
    setState(() {
      this.color = color;
    });
  }

  onColorConfirm() {
    final newJourneyType = widget.journeyType.clone();
    newJourneyType.color = color.toHex();
    widget.setJourneyType(newJourneyType);
  }

  onEditColorBtnClick() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: HexColor.fromHex(widget.journeyType.color),
              onColorChanged: onColorChange,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                onColorConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onSaveBtnClick() {
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              initialValue: widget.journeyType.type,
              onChanged: onTextChange,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Journey Type',
              ),
            ),
          ),
          const SizedBox(width: 8),
          TypeColorBlock(
            color: widget.journeyType.color,
            onClick: onEditColorBtnClick,
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.check),
        tooltip: 'Save',
        onPressed: onSaveBtnClick,
      ),
    );
  }
}
