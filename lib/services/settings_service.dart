import 'dart:async';

import 'package:bible_journey_app/services/service_base.dart';
import 'package:bible_journey_app/services/subscription.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:bible_journey_app/types/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class SettingsService extends Publisher<AppSettings> implements IService {
  final log = Logger('SettingsService');
  final FirebaseFirestore firebaseFirestore;
  late String uid;

  AppSettings appSettings = AppSettings.newEmptyRecord();
  StreamSubscription? streamSubscription;

  final List<Subscriber<AppSettings>> subscribers = [];

  SettingsService(this.firebaseFirestore);

  @override
  void init(String uid) {
    this.uid = uid;
    _subSettings();
  }

  _subSettings() {
    log.info('_subSettings - $uid $streamSubscription');
    if (streamSubscription == null) {
      final settingsDocRef = firebaseFirestore.collection('settings').doc(uid);
      streamSubscription = settingsDocRef.snapshots().listen((event) {
        if (event.exists) {
          log.info('get settings data - ${subscribers.length}');
          final data = event.data()!;
          appSettings = AppSettings.fromJson(data);
          for (final subscriber in subscribers) {
            subscriber.onData(appSettings);
          }
        } else {
          log.info('get settings data - not exist');
        }
      });
    }
  }

  @override
  dispose() {
    if (streamSubscription != null) {
      streamSubscription?.cancel();
      streamSubscription = null;
    }
  }

  @override
  void subscribe(Subscriber<AppSettings> subscriber) {
    if (!(subscribers.contains(subscriber))) {
      subscribers.add(subscriber);
      subscriber.onData(appSettings);
      log.info('subscribe - subscribed SettingsService');
    } else {
      log.info('subscribe - subscribed before');
    }
  }

  @override
  void unsubscribe(Subscriber<AppSettings> subscriber) {
    final idx = subscribers.indexOf(subscriber);
    if (idx > -1) {
      subscribers.removeAt(idx);
      log.info('unsubscribe - un-subscribed SettingsService');
    } else {
      log.info('unsubscribe - subscriber was not added before');
    }
  }

  updateSettings(AppSettings settings) async {
    try {
      if (!settings.isValid()) {
        log.info('updateSettings - invalid settings');
        return false;
      }
      log.info('updateSettings - start');
      final settingsDocRef = firebaseFirestore.collection('settings').doc(uid);
      await settingsDocRef.set({
        'journeyTypes': settings.journeyTypes.map((journeyType) => journeyType.toJson()).toList()
      });
      return true;
    } catch (err) {
      log.severe('updateSettings - err', err);
      return false;
    }
  }

  updateJourneyTypes(List<JourneyType> journeyTypes) async {
    try {
      for (final journeyType in journeyTypes) {
        if (JourneyType.isInvalid(journeyType)) {
          log.info('updateJourneyType - invalid journeyType');
          return false;
        }
      }
      log.info('updateJourneyType - start');
      final settingsDocRef = firebaseFirestore.collection('settings').doc(uid);
      final settingsDocSnapshot = await settingsDocRef.get();
      if (settingsDocSnapshot.exists) {
        log.info('updateJourneyType - update doc');
        await settingsDocRef.update({
          'journeyTypes': journeyTypes.map((journeyType) => journeyType.toJson()).toList()
        });
      } else {
        log.info('updateJourneyType - set doc');
        await settingsDocRef.set({
          'journeyTypes': journeyTypes.map((journeyType) => journeyType.toJson()).toList()
        });
      }
      return true;
    } catch (err) {
      log.severe('updateJourneyType - err', err);
      return false;
    }
  }
}
