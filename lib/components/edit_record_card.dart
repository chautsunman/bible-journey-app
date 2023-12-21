import 'package:bible_journey_app/components/book_chapter_picker.dart';
import 'package:bible_journey_app/components/type_color_block.dart';
import 'package:bible_journey_app/types/constants.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class EditRecordCard extends StatefulWidget {
  const EditRecordCard(
      {Key? key,
      required this.record,
      required this.onChange,
      required this.possibleTypes,
      required this.onSave,
      required this.onReset})
      : super(key: key);

  final JourneyRecord record;
  final void Function(JourneyRecord) onChange;
  final List<JourneyType> possibleTypes;
  final void Function() onSave;
  final void Function() onReset;

  @override
  State<EditRecordCard> createState() => _EditRecordCardState();
}

class _EditRecordCardState extends State<EditRecordCard> {
  final textTextController = TextEditingController();

  onBookChapterChange(BookChapter bookChapter) {
    final newRecord = widget.record.clone();
    newRecord.content = [bookChapter];
    widget.onChange(newRecord);
  }

  onTypeChange(JourneyType? journeyType) {
    if (journeyType != null) {
      final newRecord = widget.record.clone();
      newRecord.type = journeyType;
      widget.onChange(newRecord);
    }
  }

  editStartDate(BuildContext context) async {
    final startDate = await showDatePicker(
      context: context,
      initialDate: widget.record.readingDateStart ?? DateTime.now(),
      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Start Date',
      cancelText: 'CLEAR',
    );
    final newRecord = widget.record.clone();
    newRecord.readingDateStart = startDate;
    widget.onChange(newRecord);
  }

  editEndDate(BuildContext context) async {
    final endDate = await showDatePicker(
      context: context,
      initialDate: widget.record.readingDateStart ?? DateTime.now(),
      firstDate: widget.record.readingDateStart ??
          DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'End Date',
      cancelText: 'CLEAR',
    );
    final newRecord = widget.record.clone();
    newRecord.readingDateEnd = endDate;
    widget.onChange(newRecord);
  }

  void onTextChange() {
    final newRecord = widget.record.clone();
    newRecord.text = textTextController.text;
    widget.onChange(newRecord);
  }

  @override
  void initState() {
    super.initState();

    textTextController.addListener(onTextChange);
  }

  @override
  Widget build(BuildContext context) {
    final JourneyType? selectedJourneyType =
        widget.possibleTypes.firstWhereOrNull(
      (element) => element.id == widget.record.type.id,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Add New Journey Record'),
        BookChapterPicker(
          bookChapter: widget.record.content.isNotEmpty
              ? widget.record.content[0]
              : BookChapter.INVALID_BOOK_CHAPTER,
          onBookChapterChanged: onBookChapterChange,
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<JourneyType>(
                value: selectedJourneyType,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: onTypeChange,
                items: widget.possibleTypes
                    .map<DropdownMenuItem<JourneyType>>((JourneyType value) {
                  return DropdownMenuItem<JourneyType>(
                    value: value,
                    child: TypeColor(
                      type: value.type,
                      color: value.color,
                    ),
                  );
                }).toList(),
                isExpanded: true,
                hint: const Text('Journey Type'),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {
                editStartDate(context);
              },
              child: Text('Start Date: ${widget.record.readingDateStart}'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {
                editEndDate(context);
              },
              child: Text('End Date: ${widget.record.readingDateEnd}'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: textTextController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Text',
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: widget.onReset,
              child: const Text('RESET'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: widget.onSave,
              child: const Text('SAVE'),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    textTextController.dispose();
    super.dispose();
  }
}
