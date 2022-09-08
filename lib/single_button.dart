import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:temp_app_v1/screens/battery_screen.dart';
import 'package:temp_app_v1/screens/display_files_screen.dart';
import 'package:temp_app_v1/screens/measurement_screen.dart';
import 'package:temp_app_v1/screens/memory_card_screen.dart';
import 'package:temp_app_v1/screens/my_profile_screen.dart';
import 'package:temp_app_v1/screens/real_temperature_screen.dart';
import 'package:temp_app_v1/screens/settings_screen.dart';
import 'package:temp_app_v1/screens/time_device_screen.dart';

class SingleButton extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  final List<BluetoothService>? services;

  SingleButton(this.id, this.title, this.color, this.services);

  void selectCategory(
    BuildContext ctx,
    String id,
  ) {
    switch (id) {
      case 'a1':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return RealTemperatureScreen(
            services: services,
          );
        }));
        break;
      case 'a2':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return MeasurementScreen();
        }));
        break;
      case 'a3':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return BatteryScreen();
        }));
        break;
      case 'a4':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return MemoryCardScreen();
        }));
        break;
      case 'a5':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return DisplayFilesScreen();
        }));
        break;
      case 'a6':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return TimeDeviceScreen();
        }));
        break;
      case 'a7':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return SettingsScreen();
        }));
        break;
      case 'a8':
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return MyProfileScreen();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectCategory(
        context,
        id,
      ),
      //splashColor: Theme.of(context).primaryColor,
      //borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
