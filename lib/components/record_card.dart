import 'package:bible_journey_app/components/type_color_block.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  const RecordCard(
      {Key? key, required this.record, required this.onDeleteRecord})
      : super(key: key);

  final JourneyRecord record;
  final void Function(JourneyRecord) onDeleteRecord;

  onDeleteBtnClick() {
    onDeleteRecord(record);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(record.content[0].toString()),
          TypeColor(
            type: record.type.type,
            color: record.type.color,
          ),
          Text('${record.readingDateStart?.toString() ?? "N/A"} - ${record.readingDateEnd?.toString() ?? "N/A"}'),
          Text(record.text),
          TextButton(
            onPressed: onDeleteBtnClick,
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }
}
