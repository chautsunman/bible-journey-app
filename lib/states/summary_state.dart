import 'package:bible_journey_app/types/constants.dart';
import 'package:flutter/material.dart';

class SummaryState extends ChangeNotifier {
  BookChapter? bookChapterFilter;

  onBookChapterFilterChange(BookChapter bookChapter) {
    bookChapterFilter = bookChapter;
    notifyListeners();
  }
}
