import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/quiz_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.8,
              child: SizedBox(
                child: Text(
                  '?',
                  style: TextStyle(fontSize: 150, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: FlutterLogo(size: 100, style: FlutterLogoStyle.values.first),
            ),
            const SizedBox(height: 10),
            Text(
              "Learn Flutter the fun way!",
              style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 1),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Quiz()),
                    (f) => false,
                  );
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.transparent,
                ),
                icon: Icon(Icons.arrow_forward_ios_outlined),
                label: Text(
                  "Start Quiz",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
