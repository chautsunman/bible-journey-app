// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSummary _$BookSummaryFromJson(Map<String, dynamic> json) => BookSummary(
      Book.bookFromJson(json['book'] as String),
      (json['colors'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as String),
      ),
    );

Map<String, dynamic> _$BookSummaryToJson(BookSummary instance) =>
    <String, dynamic>{
      'book': Book.bookToJson(instance.book),
      'colors': instance.colors.map((k, e) => MapEntry(k.toString(), e)),
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) => Summary(
      Summary._bookSummariesFromJson(
          json['bookSummaries'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'bookSummaries': Summary._bookSummariesToJson(instance.bookSummaries),
    };
