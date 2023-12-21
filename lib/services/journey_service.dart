import 'package:bible_journey_app/services/service_base.dart';
import 'package:bible_journey_app/types/constants.dart';
import 'package:bible_journey_app/types/journey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class JourneyService implements IService {
  final log = Logger('JourneyService');
  final FirebaseFirestore firebaseFirestore;
  late String uid;

  JourneyService(this.firebaseFirestore);

  @override
  void init(String uid) {
    this.uid = uid;
  }

  @override
  void dispose() {

  }

  Future<List<JourneyRecord>> getJourneysForBookChapter(BookChapter bookChapter) async {
    List<JourneyRecord> journeys = [];
    if (!bookChapter.isValid()) {
      log.info('getJourneysForBookChapter - invalid bookChapter');
      return journeys;
    }
    final bookChapterStr = bookChapter.toString();
    log.info('getJourneysForBookChapter - start, $uid, $bookChapterStr');
    Query<Map<String, dynamic>> query = firebaseFirestore.collection('journeys');
    query = query.where('uid', isEqualTo: uid).where('content', arrayContains: bookChapterStr);
    final querySnapshot = await query.get();
    log.info('getJourneysForBookChapter - get data, $uid, $bookChapterStr, ${querySnapshot.size}');
    for (var docSnapshot in querySnapshot.docs) {
      journeys.add(JourneyRecord.fromJson(docSnapshot.data()));
    }
    return journeys;
  }

  addJourney(JourneyRecord journeyRecord) async {
    try {
      final journeysCollection = firebaseFirestore.collection('journeys');
      final data = journeyRecord.toJson();
      data['uid'] = uid;
      final docRef = await journeysCollection.add(data);
      log.info('addJourney - added, $uid, ${docRef.id}');
      return true;
    } catch (err) {
      log.severe('addJourney - err', err);
      return false;
    }
  }

  deleteJourney(JourneyRecord journeyRecord) async {
    try {
      final recordId = journeyRecord.id;
      log.info('deleteJourney - deleting journey $recordId');
      final journeyDoc = firebaseFirestore.collection('journeys').doc(recordId);
      await journeyDoc.delete();
      log.info('deleteJourney - deleted journey $recordId');
      return true;
    } catch (err) {
      log.severe('deleteJourney - err', err);
      return false;
    }
  }
}
