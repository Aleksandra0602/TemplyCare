import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';
import 'package:temp_app_v1/screens/log_sign_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/ripple_animate_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        backgroundColor: const Color.fromRGBO(245, 255, 245, 1),
        splash: GradientText(
          "TemplyCare",
          style: const TextStyle(
            fontSize: 42,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          colors: const [
            MyColor.appBarColor1,
            MyColor.appBarColor2,
            MyColor.appBarColor3,
          ],
        ),
        splashTransition: SplashTransition.slideTransition,
        //nextScreen: RippleAnimateScreen(),
        nextScreen: LogSignScreen(),
      ),
    );
  }
}
