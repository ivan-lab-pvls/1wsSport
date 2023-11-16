import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MainDefaultScreen.dart';
import 'OnBoarding.dart';

late SharedPreferences preferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  preferences = await SharedPreferences.getInstance();
  bool isOnBoarding = preferences.getBool('onboardingCompleted') ?? false;

  runApp(MyApp(isOnBoarding: isOnBoarding));
}

class MyApp extends StatelessWidget {
  final bool isOnBoarding;

  const MyApp({super.key, required this.isOnBoarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return isOnBoarding ? const MyHomePage() : const OnboardingScreen();
          } else {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 7, 7, 10),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset(
                        'assets/images/ball.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
