import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../screens/grid_screens/battery_screen.dart';
import '../screens/grid_screens/display_files_screen.dart';
import '../screens/grid_screens/measurement_screen.dart';
import '../screens/grid_screens/memory_card_screen.dart';
import '../screens/grid_screens/my_profile_screen.dart';
import '../screens/grid_screens/read_temperature_screen.dart';
import '../screens/grid_screens/settings_screen.dart';
import '../screens/grid_screens/time_device_screen.dart';
import '../widgets/screens.dart';

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
        return BatteryScreen();
      }));
      break;
    case ScreensEnum.memoryCardScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return MemoryCardScreen();
      }));
      break;
    case ScreensEnum.displayFilesScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return DisplayFilesScreen();
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
        return SettingsScreen();
      }));
      break;
    case ScreensEnum.myProfileScreen:
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return MyProfileScreen();
      }));
      break;
  }
}
