import 'package:flutter/material.dart';
import 'package:temp_app_v1/screens/first_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: const Text(
          "TempXDXD",
          style: TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic,
            color: Colors.amber,
          ),
        ),
        splashTransition: SplashTransition.rotationTransition,
        nextScreen: FirstScreen(),
      ),
    );
  }
}
