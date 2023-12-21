import 'package:bible_journey_app/app_components/app_context.dart';
import 'package:bible_journey_app/components/settings/journey_types_settings_card.dart';
import 'package:bible_journey_app/services/subscription.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:bible_journey_app/types/settings.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.appContext}) : super(key: key);

  final AppContext appContext;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final log = Logger('SettingsPage');

  AppSettings appSettings = AppSettings.newEmptyRecord();
  late Subscriber<AppSettings> subscriber;

  onSettingsUpdate(AppSettings appSettings) {
    log.info('onSettingsUpdate - onData, $appSettings');
    setState(() {
      this.appSettings = appSettings;
    });
  }

  onSaveNewJourneyType(JourneyType journeyType, BuildContext context) async {
    SnackBar snackBarComp;
    if (JourneyType.isInvalid(journeyType)) {
      log.info('onSaveNewJourneyType - invalid journeyType');
      snackBarComp = const SnackBar(
        content: Text('Invalid new Journey Type'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarComp);
      return;
    }
    log.info('onSaveNewJourneyType - start');
    final newJourneyTypes = [...appSettings.journeyTypes, journeyType];
    log.info('onSaveNewJourneyType - saving');
    final res = await widget.appContext.settingsService.updateJourneyTypes(newJourneyTypes);
    log.info('onSaveNewJourneyType - saved', res);
    if (res) {
      snackBarComp = const SnackBar(
        content: Text('Saved. Page is refreshing.'),
      );
    } else {
      log.info('onSaveNewJourneyType - save failed');
      snackBarComp = const SnackBar(
        content: Text('Saving error.'),
      );
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarComp);
    }
  }

  onSaveJourneyType(JourneyType journeyType, BuildContext context) async {
    SnackBar snackBarComp;
    if (JourneyType.isInvalid(journeyType)) {
      log.info('onSaveJourneyType - invalid journeyType');
      snackBarComp = const SnackBar(
        content: Text('Invalid Journey Type'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarComp);
      return;
    }
    log.info('onSaveJourneyType - start');
    final newJourneyTypes = [...appSettings.journeyTypes];
    for (var i = 0; i < newJourneyTypes.length; i++) {
      if (newJourneyTypes[i].id == journeyType.id) {
        newJourneyTypes[i] = journeyType;
      }
    }
    log.info('onSaveJourneyType - saving');
    final res = await widget.appContext.settingsService.updateJourneyTypes(newJourneyTypes);
    log.info('onSaveJourneyType - saved', res);
    if (res) {
      snackBarComp = const SnackBar(
        content: Text('Saved. Page is refreshing.'),
      );
    } else {
      log.info('onSaveJourneyType - save failed');
      snackBarComp = const SnackBar(
        content: Text('Saving error.'),
      );
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarComp);
    }
  }

  onDeleteJourneyType(JourneyType journeyType, BuildContext context) async {
    SnackBar snackBarComp;
    log.info('onDeleteJourneyType - start');
    final newJourneyTypes = [...appSettings.journeyTypes].where((_journeyType) => _journeyType.id != journeyType.id).toList();
    log.info('onDeleteJourneyType - saving');
    final res = await widget.appContext.settingsService.updateJourneyTypes(newJourneyTypes);
    log.info('onDeleteJourneyType - saved', res);
    if (res) {
      snackBarComp = const SnackBar(
        content: Text('Saved. Page is refreshing.'),
      );
    } else {
      log.info('onDeleteJourneyType - save failed');
      snackBarComp = const SnackBar(
        content: Text('Saving error.'),
      );
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarComp);
    }
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: JourneyTypesSettingsCard(
          journeyTypes: appSettings.journeyTypes,
          onSaveNewJourneyType: (JourneyType journeyType) {
            onSaveNewJourneyType(journeyType, context);
          },
          onSaveJourneyType: (JourneyType journeyType) {
            onSaveJourneyType(journeyType, context);
          },
          onDeleteJourneyType: (JourneyType journeyType) {
            onDeleteJourneyType(journeyType, context);
          },
        ),
      ),
    );
  }
}
