import 'package:bible_journey_app/components/book_chapter_picker.dart';
import 'package:bible_journey_app/types/constants.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class BibleReader extends StatefulWidget {
  const BibleReader({Key? key}) : super(key: key);

  @override
  State<BibleReader> createState() => _BibleReaderState();
}

class _BibleReaderState extends State<BibleReader> {
  final log = Logger('BibleReader');

  BookChapter bookChapter = BookChapter(Book.GENESIS, 1);

  void onBookChapterChanged(BookChapter bookChapter) {
    log.info('onBookChapterChange - ${bookChapter.toString()}');
    setState(() {
      this.bookChapter = bookChapter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookChapterPicker(bookChapter: bookChapter, onBookChapterChanged: onBookChapterChanged),
        Text(bookChapter.getBibleAppLink()),
      ],
    );
  }
}

