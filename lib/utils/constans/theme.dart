import 'package:flutter/material.dart';

import 'my_color.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: MyColor.backgroundColor,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: MyColor.darkBackgroundColor,
      accentColor: MyColor.additionalColor,
    ));

ThemeData lightTheme = ThemeData(
  backgroundColor: MyColor.backgroundColor,
);
