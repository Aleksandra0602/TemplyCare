import 'package:flutter/material.dart';

import 'my_color.dart';

ThemeData darkTheme = ThemeData(
  backgroundColor: MyColor.darkBackgroundColor,
  hoverColor: MyColor.additionalColor,
  primaryColor: MyColor.appBarColor1,
);

ThemeData lightTheme = ThemeData(
  hoverColor: MyColor.additionalColor,
  backgroundColor: MyColor.backgroundColor,
);
