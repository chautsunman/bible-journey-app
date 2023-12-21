// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => AppSettings(
      (json['journeyTypes'] as List<dynamic>)
          .map((e) => JourneyType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'journeyTypes': instance.journeyTypes,
    };
