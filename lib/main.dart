import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:temp_app_v1/screens/first_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:temp_app_v1/widgets/ripple_animate.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: GradientText(
          "TemplyCare",
          style: const TextStyle(
            fontSize: 42,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            //color: Color.fromRGBO(2, 55, 40, 0.80),
          ),
          colors: const [
            Color.fromRGBO(0, 25, 20, 0.8),
            Color.fromRGBO(1, 60, 40, 0.8),
            Color.fromRGBO(2, 90, 60, 0.8),
          ],
        ),
        splashTransition: SplashTransition.slideTransition,
        nextScreen: RippleAnimate(),
      ),
    );
  }
}
