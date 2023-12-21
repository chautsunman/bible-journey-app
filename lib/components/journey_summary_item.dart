import 'package:bible_journey_app/components/type_color_block.dart';
import 'package:bible_journey_app/types/constants.dart';
import 'package:bible_journey_app/types/summary.dart';
import 'package:flutter/material.dart';

class JourneySummaryItem extends StatelessWidget {
  const JourneySummaryItem({Key? key, required this.bookSummary, required this.onSelectBookChapter}) : super(key: key);

  final BookSummary bookSummary;
  final void Function(BookChapter) onSelectBookChapter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [for (var i = 1; i <= bookSummary.book.numChapters; i++) i]
                .map((e) => TypeColor(
                      type: e.toString(),
                      color: bookSummary.getChapterColor(e),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

