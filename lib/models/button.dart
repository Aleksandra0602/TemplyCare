import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:temp_app_v1/models/screens.dart';

class Button {
  final String id;
  final String title;
  final Color color;
  final ScreensEnum screens;

  const Button(
      {required this.id,
      required this.title,
      required this.color,
      required this.screens});
}
