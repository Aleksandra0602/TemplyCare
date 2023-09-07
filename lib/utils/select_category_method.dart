import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../screens/main_screens/battery_screen.dart';
import '../screens/main_screens/display_files_screen.dart';
import '../screens/main_screens/measurement_screen.dart';
import '../screens/main_screens/memory_card_screen.dart';
import '../screens/bottom_screens/my_profile_screen.dart';
import '../screens/main_screens/read_temperature_screen.dart';
import '../screens/bottom_screens/settings_screen.dart';
import '../screens/main_screens/time_device_screen.dart';
import 'constans/screens.dart';

void selectCategory(
  BuildContext ctx,
  ScreensEnum screens,
  List<BluetoothService>? services,
) {
  switch (screens) {
    case ScreensEnum.realTemperatureScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return ReadTemperatureScreen(
          services: services,
        );
      }));
      break;
    case ScreensEnum.measurementScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return MeasurementScreen(
          services: services,
        );
      }));
      break;
    case ScreensEnum.batteryScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return BatteryScreen(
          services: services,
        );
      }));
      break;
    case ScreensEnum.memoryCardScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return MemoryCardScreen(
          services: services,
        );
      }));
      break;
    case ScreensEnum.displayFilesScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return DisplayFilesScreen(
          services: services,
        );
      }));
      break;
    case ScreensEnum.timeDeviceScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return TimeDeviceScreen(
          services: services,
        );
      }));
      break;
    case ScreensEnum.settingsScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return const SettingsScreen();
      }));
      break;
    case ScreensEnum.myProfileScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return const MyProfileScreen();
      }));
      break;
  }
}
