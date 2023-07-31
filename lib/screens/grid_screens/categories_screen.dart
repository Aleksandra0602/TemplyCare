import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/screens/grid_screens/measurement_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/my_profile_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/read_temperature_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/screen_main.dart';
import 'package:temp_app_v1/screens/grid_screens/settings_screen.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/constans/screens.dart';
import 'package:temp_app_v1/utils/select_category_method.dart';
import 'package:temp_app_v1/widgets/main_drawer.dart';
import 'package:temp_app_v1/widgets/my_bottom_nav_bar.dart';

import '../../widgets/button_data.dart';
import '../../widgets/single_button.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    this.services,
  });

  final List<BluetoothService>? services;
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String temperature = "";
  List<double> trace = [];
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();
  List<int> value = [];
  int currentIndex = 0;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      ScreenMain(services: widget.services),
      ReadTemperatureScreen(
        services: widget.services,
      ),
      MeasurementScreen(services: widget.services),
      SettingsScreen(),
      MyProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,

        drawer: const MainDrawer(),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyColor.backgroundColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          selectedItemColor: MyColor.additionalColor,
          selectedFontSize: 14,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedItemColor: MyColor.primary8,
          unselectedIconTheme: const IconThemeData(color: MyColor.primary8),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Główna'),
            BottomNavigationBarItem(
              icon: Icon(Icons.data_exploration),
              label: 'Aktualności',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shutter_speed), label: 'Pomiar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Ustawienia'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
        // body: GridView(
        //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: Dimensions.HEIGHT,
        //     childAspectRatio: 1,
        //     crossAxisSpacing: Dimensions.SPACE,
        //     mainAxisSpacing: Dimensions.SPACE,
        //   ),
        //   padding: const EdgeInsets.all(10),
        //   children: BUTTON_DATA
        //       .map((butData) => SingleButton(
        //           butData.title, butData.color, widget.services, butData.screens))
        //       .toList(),
        // ),
        body: screens[currentIndex],
      ),
    );
  }
}
