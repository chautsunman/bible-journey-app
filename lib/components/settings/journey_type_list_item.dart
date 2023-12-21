import 'package:bible_journey_app/components/settings/journey_type_edit_item.dart';
import 'package:bible_journey_app/components/type_color_block.dart';
import 'package:bible_journey_app/types/general.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:flutter/material.dart';

class JourneyTypeListItem extends StatefulWidget {
  const JourneyTypeListItem(
      {Key? key,
      required this.initData,
      required this.onSave,
      required this.onDelete})
      : super(key: key);

  final JourneyType initData;
  final void Function(JourneyType) onSave;
  final void Function(JourneyType) onDelete;

  @override
  State<JourneyTypeListItem> createState() => _JourneyTypeListItemState();
}

class _JourneyTypeListItemState extends State<JourneyTypeListItem> {
  JourneyType journeyType = JourneyType.newEmptyRecord();
  RecordState recordState = RecordState.READ;

  setJourneyType(JourneyType journeyType) {
    setState(() {
      this.journeyType = journeyType;
    });
  }

  onEditBtnClick() {
    setState(() {
      recordState = RecordState.EDIT;
    });
  }

  onDeleteBtnClick() {
    widget.onDelete(journeyType);
  }

  onSaveBtnClick() {
    widget.onSave(journeyType);
    setState(() {
      recordState = RecordState.READ;
    });
  }

  @override
  void initState() {
    super.initState();

    journeyType = widget.initData;
  }

  @override
  void didUpdateWidget(covariant JourneyTypeListItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initData != widget.initData) {
      setState(() {
        journeyType = widget.initData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recordState == RecordState.READ) {
      return ListTile(
        title: TypeColor(
          type: journeyType.type,
          color: journeyType.color,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
              onPressed: onEditBtnClick,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete',
              onPressed: onDeleteBtnClick,
            ),
          ],
        ),
      );
    } else {
      return JourneyTypeEditItem(
        journeyType: journeyType,
        setJourneyType: setJourneyType,
        onSave: onSaveBtnClick,
      );
    }
  }
}
