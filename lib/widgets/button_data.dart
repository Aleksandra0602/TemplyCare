import 'package:flutter/material.dart';
import 'package:temp_app_v1/widgets/screens.dart';

import 'button.dart';

// ignore: unnecessary_const
const BUTTON_DATA = const [
  Button(
      title: 'Podgląd aktualnych danych',
      color: Color.fromRGBO(0, 60, 60, 1),
      screens: ScreensEnum.realTemperatureScreen),
  Button(
      title: 'Wykonaj pomiar',
      color: Color.fromRGBO(0, 80, 80, 1),
      screens: ScreensEnum.measurementScreen),
  Button(
      title: 'Stan baterii',
      color: Color.fromRGBO(0, 100, 100, 1),
      screens: ScreensEnum.batteryScreen),
  Button(
      title: 'Stan karty pamięci',
      color: Color.fromRGBO(0, 115, 115, 1),
      screens: ScreensEnum.memoryCardScreen),
  Button(
      title: 'Podgląd plików',
      color: Color.fromRGBO(0, 130, 130, 1),
      screens: ScreensEnum.displayFilesScreen),
  Button(
      title: 'Czas na urządzeniu',
      color: Color.fromRGBO(0, 150, 150, 1),
      screens: ScreensEnum.timeDeviceScreen),
  Button(
      title: 'Ustawienia',
      color: Color.fromRGBO(0, 180, 180, 1),
      screens: ScreensEnum.settingsScreen),
  Button(
      title: 'Mój profil',
      color: Color.fromRGBO(0, 200, 200, 1),
      screens: ScreensEnum.myProfileScreen),
];
