import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winnerfootball/news/first.dart';
import 'MainDefaultScreen.dart';
import 'OnBoarding.dart';
import 'news/dar.dart';
import 'news/data.dart';
import 'presentation/matc/data/datax.dart';
import 'presentation/matc/showPrivacy.dart';
import 'presentation/notification.dart';

late SharedPreferences prefs;
final remoteConfig = FirebaseRemoteConfig.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 3),
    minimumFetchInterval: const Duration(seconds: 3),
  ));
  await NotificationServiceFb().activate();
  final bool isMatchesLive = await checkMatchesData();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    showMatches: isMatchesLive,
  ));
}

class MyApp extends StatelessWidget {
  final bool showMatches;
  const MyApp({super.key, required this.showMatches});

  @override
  Widget build(BuildContext context) {
    if (isMatchesLiveShow != '') {
      return HelpDeskView(
        show: isMatchesLiveShow,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: gettingdataForOnBoarding(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return StartScreen();
          } else {
            final bool boolValue = snapshot.data ?? false;
            if (boolValue) {
              return const MyHomePage();
            } else {
              return const OnboardingScreen();
            }
          }
        },
      ),
    );
  }

  Future<bool> gettingdataForOnBoarding() async {
    final bool value = prefs.getBool('onboardingCompleted') ?? false;

    await Future.delayed(const Duration(seconds: 3));

    return value;
  }
}
