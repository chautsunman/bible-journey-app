import 'package:bible_journey_app/components/settings/journey_type_edit_item.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:flutter/material.dart';

class JourneyTypeNewItem extends StatefulWidget {
  const JourneyTypeNewItem({Key? key, required this.onSave}) : super(key: key);

  final void Function(JourneyType) onSave;

  @override
  State<JourneyTypeNewItem> createState() => _JourneyTypeNewItemState();
}

class _JourneyTypeNewItemState extends State<JourneyTypeNewItem> {
  JourneyType journeyType = JourneyType.newEmptyRecord();

  setJourneyType(JourneyType journeyType) {
    setState(() {
      this.journeyType = journeyType;
    });
  }

  onSaveBtnClick() {
    widget.onSave(journeyType);
    setState(() {
      journeyType = JourneyType.newEmptyRecord();
    });
  }

  @override
  Widget build(BuildContext context) {
    return JourneyTypeEditItem(
      journeyType: journeyType,
      setJourneyType: setJourneyType,
      onSave: onSaveBtnClick,
    );
  }
}
