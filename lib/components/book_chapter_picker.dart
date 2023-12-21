import 'package:bible_journey_app/types/constants.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class BookChapterPicker extends StatelessWidget {
  final log = Logger('BookChapterPicker');

  BookChapterPicker({Key? key, required this.bookChapter, required this.onBookChapterChanged}) : super(key: key);

  final BookChapter bookChapter;
  final void Function(BookChapter) onBookChapterChanged;

  void onBookChange(String? value) {
    var book = getBookFromName(value!);
    log.info('onBookChange - $value, $book');
    if (book.isValid()) {
      onBookChapterChanged(BookChapter(book, 1));
    }
  }

  void onChapterChange(int? value) {
    log.info('onChapterChange - $value');
    if (value != null && value > 0 && value <= bookChapter.book.numChapters) {
      onBookChapterChanged(BookChapter(bookChapter.book, value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: bookChapter.book.name,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: onBookChange,
            items: BOOK_NAMES.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
          ),
        ),
        Container(
          width: 16.0,
        ),
        Expanded(
          child: DropdownButton<int>(
            value: bookChapter.chapter,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: onChapterChange,
            items: [for (var i = 1; i <= bookChapter.book.numChapters; i++) i]
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
