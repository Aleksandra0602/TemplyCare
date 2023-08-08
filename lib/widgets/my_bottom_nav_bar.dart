import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/utils/constans/my_color.dart';

class MyButtonNavBar extends StatelessWidget {
  MyButtonNavBar({required this.currentIndex, required this.onTapped});
  //final List<BluetoothService>? services;

  final int currentIndex;
  final ValueChanged<int> onTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: MyColor.backgroundColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTapped,
      selectedItemColor: MyColor.additionalColor,
      selectedFontSize: 14,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedItemColor: MyColor.primary8,
      unselectedIconTheme: const IconThemeData(color: MyColor.primary7),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.data_exploration),
          label: 'Aktualności',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shutter_speed),
          label: 'Pomiar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Ustawienia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
