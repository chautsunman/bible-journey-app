// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JourneyType _$JourneyTypeFromJson(Map<String, dynamic> json) => JourneyType(
      json['id'] as String,
      json['type'] as String,
      json['color'] as String,
    );

Map<String, dynamic> _$JourneyTypeToJson(JourneyType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'color': instance.color,
    };

JourneyRecord _$JourneyRecordFromJson(Map<String, dynamic> json) =>
    JourneyRecord(
      json['id'] as String,
      JourneyRecord._contentFromJson(json['content'] as List<String>),
      json['readingDateStart'] == null
          ? null
          : DateTime.parse(json['readingDateStart'] as String),
      json['readingDateEnd'] == null
          ? null
          : DateTime.parse(json['readingDateEnd'] as String),
      JourneyType.fromJson(json['type'] as Map<String, dynamic>),
      json['text'] as String,
    );

Map<String, dynamic> _$JourneyRecordToJson(JourneyRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': JourneyRecord._contentToJson(instance.content),
      'readingDateStart': instance.readingDateStart?.toIso8601String(),
      'readingDateEnd': instance.readingDateEnd?.toIso8601String(),
      'type': instance.type.toJson(),
      'text': instance.text,
    };
