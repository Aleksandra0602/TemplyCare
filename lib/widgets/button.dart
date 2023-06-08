import 'package:flutter/material.dart';
import 'package:temp_app_v1/widgets/screens.dart';

class Button {
  final String title;
  final Color color;
  final ScreensEnum screens;

  const Button(
      {required this.title, required this.color, required this.screens});
}
