import 'package:bible_journey_app/services/journey_service.dart';
import 'package:bible_journey_app/services/settings_service.dart';
import 'package:bible_journey_app/services/summary_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppContext extends ChangeNotifier {
  late JourneyService journeyService;
  late SettingsService settingsService;
  late SummaryService summaryService;

  AppContext(String uid) {
    journeyService = JourneyService(FirebaseFirestore.instance);
    settingsService = SettingsService(FirebaseFirestore.instance);
    summaryService = SummaryService(FirebaseFirestore.instance);

    journeyService.init(uid);
    settingsService.init(uid);
    summaryService.init(uid);
  }

  @override
  dispose() {
    super.dispose();

    journeyService.dispose();
    settingsService.dispose();
    summaryService.dispose();
  }
}
