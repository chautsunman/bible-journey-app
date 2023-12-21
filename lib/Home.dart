import 'package:bible_journey_app/app_components/app_context.dart';
import 'package:bible_journey_app/components/bible_reader.dart';
import 'package:bible_journey_app/components/journey_records.dart';
import 'package:bible_journey_app/components/journey_summary.dart';
import 'package:bible_journey_app/settings_page.dart';
import 'package:bible_journey_app/states/summary_state.dart';
import 'package:bible_journey_app/types/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bible Journey'),
        actions: [
          Consumer<AppContext>(
            builder: (context, appContext, child) {
              return TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(
                        appContext: appContext,
                      ),
                    ),
                  );
                },
                child: const Text('Settings'),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: BibleReader(),
                    ),
                  ),
                  Container(
                    height: 16.0,
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Consumer<AppContext>(
                            builder: (context, appContext, child) {
                          return JourneySummary(
                            appContext: appContext,
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Consumer<AppContext>(
                          builder: (context, appContext, child) {
                            return Consumer<SummaryState>(
                              builder: (context, summaryState, child) {
                                return JourneyRecordsPage(
                                  appContext: appContext,
                                  summaryState: summaryState,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
