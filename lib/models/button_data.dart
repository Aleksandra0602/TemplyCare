import 'package:flutter/material.dart';
import 'package:temp_app_v1/models/screens.dart';

import 'button.dart';

// ignore: unnecessary_const
const BUTTON_DATA = const [
  Button(
      id: 'a1',
      title: 'Podgląd aktualnych danych',
      color: Color.fromRGBO(0, 60, 60, 1),
      screens: ScreensEnum.realTemperatureScreen),
  Button(
      id: 'a2',
      title: 'Wykonaj pomiar',
      color: Color.fromRGBO(0, 80, 80, 1),
      screens: ScreensEnum.measurementScreen),
  Button(
      id: 'a3',
      title: 'Stan baterii',
      color: Color.fromRGBO(0, 100, 100, 1),
      screens: ScreensEnum.batteryScreen),
  Button(
      id: 'a4',
      title: 'Stan karty pamięci',
      color: Color.fromRGBO(0, 115, 115, 1),
      screens: ScreensEnum.memoryCardScreen),
  Button(
      id: 'a5',
      title: 'Podgląd plików',
      color: Color.fromRGBO(0, 130, 130, 1),
      screens: ScreensEnum.displayFilesScreen),
  Button(
      id: 'a6',
      title: 'Czas na urządzeniu',
      color: Color.fromRGBO(0, 150, 150, 1),
      screens: ScreensEnum.timeDeviceScreen),
  Button(
      id: 'a7',
      title: 'Ustawienia',
      color: Color.fromRGBO(0, 180, 180, 1),
      screens: ScreensEnum.settingsScreen),
  Button(
      id: 'a8',
      title: 'Mój profil',
      color: Color.fromRGBO(0, 200, 200, 1),
      screens: ScreensEnum.myProfileScreen),
];
