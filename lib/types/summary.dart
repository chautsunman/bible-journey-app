import 'dart:convert';

import 'package:bible_journey_app/types/constants.dart';
import 'package:bible_journey_app/types/general.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary.g.dart';

@JsonSerializable(explicitToJson: true)
class BookSummary extends ValidObj {
  @JsonKey(
    toJson: Book.bookToJson,
    fromJson: Book.bookFromJson,
  )
  final Book book;
  final Map<int, String> colors;

  BookSummary(this.book, this.colors);

  getChapterColor(int chapter) {
    return colors.containsKey(chapter) ? colors[chapter] : '#999999';
  }

  @override
  isValid() {
    return book.isValid();
  }

  factory BookSummary.emptyBookSummary(Book book) {
    return BookSummary(book, {});
  }

  factory BookSummary.fromJson(Map<String, dynamic> json) => _$BookSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$BookSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Summary {
  @JsonKey(
    toJson: _bookSummariesToJson,
    fromJson: _bookSummariesFromJson,
  )
  final Map<Book, BookSummary> bookSummaries;

  Summary(this.bookSummaries);

  getBookSummary(Book book) {
    return bookSummaries.containsKey(book) ? bookSummaries[book] : BookSummary.emptyBookSummary(book);
  }

  factory Summary.emptySummary() {
    return Summary({});
  }

  factory Summary.fromJson(Map<String, dynamic> json) => _$SummaryFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryToJson(this);

  static Map<String, dynamic> _bookSummariesToJson(Map<Book, BookSummary> bookSummaries) {
    return bookSummaries.map((key, value) => MapEntry(Book.bookToJson(key), value.toJson()));
  }
  static Map<Book, BookSummary> _bookSummariesFromJson(Map<String, dynamic> jsonObj) {
    Map<Book, BookSummary> bookSummaries = {};
    jsonObj.forEach((key, value) {
      final book = Book.bookFromJson(key);
      if (book.isValid()) {
        final bookSummary = BookSummary.fromJson(value);
        if (bookSummary.isValid()) {
          bookSummaries[book] = bookSummary;
        }
      }
    });
    return bookSummaries;
  }
}
