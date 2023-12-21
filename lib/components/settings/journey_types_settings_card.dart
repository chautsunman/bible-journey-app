import 'package:bible_journey_app/components/settings/journey_type_list_item.dart';
import 'package:bible_journey_app/components/settings/journey_type_new_item.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:flutter/material.dart';

class JourneyTypesSettingsCard extends StatelessWidget {
  const JourneyTypesSettingsCard(
      {Key? key,
      required this.journeyTypes,
      required this.onSaveNewJourneyType,
      required this.onSaveJourneyType,
      required this.onDeleteJourneyType})
      : super(key: key);

  final List<JourneyType> journeyTypes;
  final void Function(JourneyType) onSaveNewJourneyType;
  final void Function(JourneyType) onSaveJourneyType;
  final void Function(JourneyType) onDeleteJourneyType;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Journey Types'),
            JourneyTypeNewItem(
              onSave: onSaveNewJourneyType,
            ),
            SizedBox(
              height: 400.0,
              child: ListView.builder(
                itemCount: journeyTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return JourneyTypeListItem(
                    initData: journeyTypes[index],
                    onSave: onSaveJourneyType,
                    onDelete: onDeleteJourneyType,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
