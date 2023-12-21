import 'package:bible_journey_app/Home.dart';
import 'package:bible_journey_app/app_components/app_context.dart';
import 'package:bible_journey_app/sign_in_screen.dart';
import 'package:bible_journey_app/states/summary_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final log = Logger('App');

  bool signedIn = false;
  AppContext? appContext;
  SummaryState? summaryState;

  @override
  Widget build(BuildContext context) {
    if (signedIn) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => appContext,
          ),
          ChangeNotifierProvider(
            create: (context) => summaryState,
          ),
        ],
        child: const HomePage(),
      );
    } else {
      return const SignInScreen();
    }
    return const Placeholder();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log.info('User is currently signed out!');
        setState(() {
          signedIn = false;
          if (appContext != null) {
            appContext?.dispose();
            appContext = null;
          }
          summaryState = null;
        });
      } else {
        log.info('User is signed in!');
        setState(() {
          signedIn = true;
          appContext = AppContext(user.uid);
          summaryState = SummaryState();
        });
      }
    });
  }
}
