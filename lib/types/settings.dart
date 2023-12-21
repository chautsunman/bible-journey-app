import 'package:bible_journey_app/types/general.dart';
import 'package:json_annotation/json_annotation.dart';
import 'journey.dart';

part 'settings.g.dart';

@JsonSerializable()
class AppSettings extends ValidObj {
  final List<JourneyType> journeyTypes;

  AppSettings(this.journeyTypes);

  @override
  isValid() {
    for (final journeyType in journeyTypes) {
      if (JourneyType.isInvalid(journeyType)) {
        return false;
      }
    }
    return true;
  }

  static newEmptyRecord() {
    return AppSettings([]);
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}
