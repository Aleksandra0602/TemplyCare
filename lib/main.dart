import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/screens/ripple_animate_screen.dart';

import 'package:temp_app_v1/utils/translations/local_strings.dart';
import 'package:temp_app_v1/utils/scale_utils/scale_controller.dart';

void main() {
  Get.put(ScaleController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalStrings(),
      locale: const Locale('pl', 'PL'),
      darkTheme: ThemeData.dark(),
      theme:
          ThemeData.light().copyWith(backgroundColor: MyColor.backgroundColor),
      themeMode: ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: MyColor.backgroundColor,
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
        nextScreen: const RippleAnimateScreen(),
      ),
    );
  }
}
