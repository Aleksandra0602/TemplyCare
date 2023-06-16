import 'package:flutter/material.dart';
import 'package:temp_app_v1/widgets/screens.dart';

import 'button.dart';

// ignore: unnecessary_const, constant_identifier_names
const BUTTON_DATA = const [
  Button(
      title: 'Podgląd aktualnych danych',
      color: Color.fromRGBO(0, 50, 40, 1),
      screens: ScreensEnum.realTemperatureScreen),
  Button(
      title: 'Wykonaj pomiar',
      color: Color.fromRGBO(0, 65, 55, 1),
      screens: ScreensEnum.measurementScreen),
  Button(
      title: 'Stan baterii',
      color: Color.fromRGBO(0, 80, 70, 1),
      screens: ScreensEnum.batteryScreen),
  Button(
      title: 'Stan karty pamięci',
      color: Color.fromRGBO(0, 95, 85, 1),
      screens: ScreensEnum.memoryCardScreen),
  Button(
      title: 'Podgląd plików',
      color: Color.fromRGBO(0, 110, 100, 1),
      screens: ScreensEnum.displayFilesScreen),
  Button(
      title: 'Czas na urządzeniu',
      color: Color.fromRGBO(0, 125, 115, 1),
      screens: ScreensEnum.timeDeviceScreen),
  Button(
      title: 'Ustawienia',
      color: Color.fromRGBO(0, 140, 130, 1),
      screens: ScreensEnum.settingsScreen),
  Button(
      title: 'Mój profil',
      color: Color.fromRGBO(0, 155, 145, 1),
      screens: ScreensEnum.myProfileScreen),
];
