import 'package:bible_journey_app/app_components/app_context.dart';
import 'package:bible_journey_app/components/edit_record_card.dart';
import 'package:bible_journey_app/services/subscription.dart';
import 'package:bible_journey_app/states/summary_state.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:bible_journey_app/types/settings.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class JourneyRecordsPage extends StatefulWidget {
  const JourneyRecordsPage({Key? key, required this.appContext, required this.summaryState}) : super(key: key);

  final AppContext appContext;
  final SummaryState summaryState;

  @override
  State<JourneyRecordsPage> createState() => _JourneyRecordsPageState();
}

class _JourneyRecordsPageState extends State<JourneyRecordsPage> {
  final log = Logger('JourneyRecords');

  JourneyRecord newJourneyRecord = JourneyRecord.newEmptyRecord();
  AppSettings appSettings = AppSettings.newEmptyRecord();
  late Subscriber<AppSettings> subscriber;

  void onNewRecordChange(JourneyRecord journeyRecord) {
    setState(() {
      newJourneyRecord = journeyRecord;
    });
  }

  void onResetNewRecord() {
    log.info('onResetNewRecord');
    setState(() {
      newJourneyRecord = JourneyRecord.newEmptyRecord();
    });
  }

  void onSaveNewRecord(BuildContext context) async {
    SnackBar snackBarComp;
    if (!newJourneyRecord.isValid()) {
      log.info('onSaveNewRecord - invalid record');
      snackBarComp = const SnackBar(
        content: Text('Invalid record to save'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarComp);
      return;
    }
    log.info('onSaveNewRecord - save start');
    final res = await widget.appContext.journeyService.addJourney(newJourneyRecord);
    log.info('onSaveNewRecord - save end, $res');
    if (res) {
      snackBarComp = const SnackBar(
        content: Text('Saved'),
      );
    } else {
      snackBarComp = const SnackBar(
        content: Text('Save error.'),
      );
    }
    onResetNewRecord();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarComp);
    }
  }

  onSettingsUpdate(AppSettings appSettings) {
    log.info('onSettingsUpdate - onData, $appSettings');
    setState(() {
      this.appSettings = appSettings;
    });
  }

  @override
  void initState() {
    super.initState();

    subscriber = SubscriberImpl(onSettingsUpdate);
    widget.appContext.settingsService.subscribe(subscriber);
  }

  @override
  void dispose() {
    super.dispose();

    widget.appContext.settingsService.unsubscribe(subscriber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditRecordCard(
          record: newJourneyRecord,
          onChange: onNewRecordChange,
          possibleTypes: appSettings.journeyTypes,
          onSave: () {
            onSaveNewRecord(context);
          },
          onReset: onResetNewRecord,
        ),
      ],
    );
  }
}

