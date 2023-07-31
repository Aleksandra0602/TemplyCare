import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/constans/screens.dart';

import 'button.dart';

// ignore: unnecessary_const, constant_identifier_names
const BUTTON_DATA = const [
  Button(
      title: 'Podgląd aktualnych danych',
      color: MyColor.primary1,
      screens: ScreensEnum.realTemperatureScreen),
  Button(
      title: 'Wykonaj pomiar',
      color: MyColor.primary2,
      screens: ScreensEnum.measurementScreen),
  Button(
      title: 'Stan baterii',
      color: MyColor.primary3,
      screens: ScreensEnum.batteryScreen),
  Button(
      title: 'Stan karty pamięci',
      color: MyColor.primary4,
      screens: ScreensEnum.memoryCardScreen),
  Button(
      title: 'Podgląd plików',
      color: MyColor.primary5,
      screens: ScreensEnum.displayFilesScreen),
  Button(
      title: 'Czas na urządzeniu',
      color: MyColor.primary6,
      screens: ScreensEnum.timeDeviceScreen),
  Button(
      title: 'Ustawienia',
      color: MyColor.primary7,
      screens: ScreensEnum.settingsScreen),
  Button(
      title: 'Mój profil',
      color: MyColor.primary8,
      screens: ScreensEnum.myProfileScreen),
];
