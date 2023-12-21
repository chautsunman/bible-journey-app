import 'dart:async';

import 'package:bible_journey_app/services/service_base.dart';
import 'package:bible_journey_app/services/subscription.dart';
import 'package:bible_journey_app/types/summary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class SummaryService extends Publisher<Summary> implements IService {
  final log = Logger('SummaryService');
  final FirebaseFirestore firebaseFirestore;
  late String uid;

  Summary summary = Summary.emptySummary();
  StreamSubscription? streamSubscription;

  final List<Subscriber<Summary>> subscribers = [];

  SummaryService(this.firebaseFirestore);

  @override
  void init(String uid) {
    this.uid = uid;
    _subSummary();
  }

  _subSummary() {
    log.info('_subSummary - $uid $streamSubscription');
    if (streamSubscription == null) {
      final summaryDocRef = firebaseFirestore.collection('summary').doc(uid);
      streamSubscription = summaryDocRef.snapshots().listen((event) {
        if (event.exists) {
          log.info('get summary data - ${subscribers.length}');
          final data = event.data()!;
          summary = Summary.fromJson(data);
          for (final subscriber in subscribers) {
            subscriber.onData(summary);
          }
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
  void subscribe(Subscriber<Summary> subscriber) {
    if (!(subscribers.contains(subscriber))) {
      subscribers.add(subscriber);
      subscriber.onData(summary);
      log.info('subscribe - subscribed SummaryService');
    } else {
      log.info('subscribe - subscribed before');
    }
  }

  @override
  void unsubscribe(Subscriber<Summary> subscriber) {
    final idx = subscribers.indexOf(subscriber);
    if (idx > -1) {
      subscribers.removeAt(idx);
      log.info('unsubscribe - un-subscribed SummaryService');
    } else {
      log.info('unsubscribe - subscriber was not added before');
    }
  }
}
