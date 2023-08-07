import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/screens/grid_screens/measurement_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/my_profile_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/read_temperature_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/screen_main.dart';
import 'package:temp_app_v1/screens/grid_screens/settings_screen.dart';

import 'package:temp_app_v1/utils/constans/my_color.dart';

import 'package:temp_app_v1/widgets/main_drawer.dart';

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
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.bottomBar1),
            BottomNavigationBarItem(
              icon: const Icon(Icons.data_exploration),
              label: AppLocalizations.of(context)!.bottomBar2,
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.shutter_speed),
                label: AppLocalizations.of(context)!.bottomBar3),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: AppLocalizations.of(context)!.bottomBar4),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: AppLocalizations.of(context)!.bottomBar5),
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
