import 'dart:convert';

import 'package:bible_journey_app/types/general.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:bible_journey_app/types/constants.dart';

part 'journey.g.dart';

@JsonSerializable()
class JourneyType {
  final String id;
  String type;
  String color;

  JourneyType(this.id, this.type, this.color);

  clone() {
    return JourneyType(id, type, color);
  }

  static JourneyType INVALID_JOURNEY_TYPE = JourneyType('invalidJourneyType', 'invalidJourneyType', '#000000');
  static bool isInvalid(JourneyType journeyType) {
    return journeyType == JourneyType.INVALID_JOURNEY_TYPE || journeyType.id == 'invalidJourneyType';
  }

  factory JourneyType.newEmptyRecord() {
    return JourneyType(const Uuid().v4(), '', '#000000');
  }

  factory JourneyType.fromJson(Map<String, dynamic> json) => _$JourneyTypeFromJson(json);
  Map<String, dynamic> toJson() => _$JourneyTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class JourneyRecord extends ValidObj {
  final String id;
  @JsonKey(
    toJson: _contentToJson,
    fromJson: _contentFromJson,
  )
  List<BookChapter> content;
  DateTime? readingDateStart;
  DateTime? readingDateEnd;
  JourneyType type;
  String text;

  JourneyRecord(this.id, this.content, this.readingDateStart, this.readingDateEnd, this.type, this.text);

  @override
  isValid() {
    if (content.isEmpty) {
      return false;
    }
    if (readingDateStart != null && readingDateEnd != null && readingDateStart!.isAfter(readingDateEnd!)) {
      return false;
    }
    if (JourneyType.isInvalid(type)) {
      return false;
    }
    if (text.isEmpty) {
      return false;
    }
    return true;
  }

  clone() {
    return JourneyRecord(id, content, readingDateStart, readingDateEnd, type, text);
  }

  factory JourneyRecord.newEmptyRecord() {
    return JourneyRecord(const Uuid().v4(), [BookChapter(Book.GENESIS, 1)], null, null, JourneyType.INVALID_JOURNEY_TYPE, '');
  }

  factory JourneyRecord.fromJson(Map<String, dynamic> json) => _$JourneyRecordFromJson(json);
  Map<String, dynamic> toJson() => _$JourneyRecordToJson(this);

  static List<dynamic> _contentToJson(List<BookChapter> content) {
    return content.map((e) => const BookChapterJsonConvertor().toJson(e)).toList();
  }
  static List<BookChapter> _contentFromJson(List<String> jsonStr) {
    return jsonStr.map((e) => const BookChapterJsonConvertor().fromJson(e)).toList();
  }
}
