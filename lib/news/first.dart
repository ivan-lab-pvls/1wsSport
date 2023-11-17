import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
