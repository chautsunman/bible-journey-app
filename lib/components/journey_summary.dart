import 'package:bible_journey_app/app_components/app_context.dart';
import 'package:bible_journey_app/components/journey_summary_item.dart';
import 'package:bible_journey_app/services/subscription.dart';
import 'package:bible_journey_app/states/summary_state.dart';
import 'package:bible_journey_app/types/constants.dart';
import 'package:bible_journey_app/types/summary.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class JourneySummary extends StatefulWidget {
  const JourneySummary({Key? key, required this.appContext}) : super(key: key);

  final AppContext appContext;

  @override
  State<JourneySummary> createState() => _JourneySummaryState();
}

class _JourneySummaryState extends State<JourneySummary> {
  final log = Logger('JourneySummary');

  Summary summary = Summary.emptySummary();
  late Subscriber<Summary> subscriber;

  onSummaryUpdate(Summary summary) {
    log.info('onSummaryUpdate - onData, $summary');
    setState(() {
      this.summary = summary;
    });
  }

  onSelectBookChapter(BuildContext context, BookChapter bookChapter) {
    Provider.of<SummaryState>(context, listen: false).onBookChapterFilterChange(bookChapter);
  }

  @override
  void initState() {
    super.initState();

    subscriber = SubscriberImpl(onSummaryUpdate);
    widget.appContext.summaryService.subscribe(subscriber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Journey Summary'),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            itemCount: BOOKS.length,
            itemBuilder: (BuildContext context, int index) {
              return JourneySummaryItem(
                bookSummary: summary.getBookSummary(BOOKS[index]),
                onSelectBookChapter: (BookChapter bookChapter) {
                  onSelectBookChapter(context, bookChapter);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

