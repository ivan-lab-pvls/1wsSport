// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MainDefaultScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPageIndex = 0;
  bool onboardingCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 7, 10),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: onboardingPages.length,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return onboardingPages[index];
              },
            ),
          ),
          if (currentPageIndex == onboardingPages.length - 1 &&
              !onboardingCompleted)
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return const MyHomePage();
                  },
                ));
                setState(() {
                  onboardingCompleted = true;
                });
                saveOnboardingCompletionStatus(true);
              },
              child: Container(
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
                child: const Center(
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 40,
          ),
          DotsIndicator(
            dotsCount: onboardingPages.length,
            position: currentPageIndex,
            decorator: const DotsDecorator(
              activeColor: Color.fromARGB(255, 243, 222, 33),
              size: Size(10, 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void saveOnboardingCompletionStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingCompleted', value);
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({super.key, 
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 7, 7, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 250),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

final List<OnboardingPage> onboardingPages = [
  const OnboardingPage(
    imagePath: 'assets/images/field.png',
    title: 'Indispensable companion for any football enthusiast',
    description:
        'Whether you\'re a seasoned punter or just a casual fan looking to add some spice to matchdays',
  ),
  const OnboardingPage(
    imagePath: 'assets/images/review.png',
    title: 'We value your feedback',
    description:
        'Every day we are getting better due to your ratings and reviews — that helps us protect your accounts.',
  ),
];
