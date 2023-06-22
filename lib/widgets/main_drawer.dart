import 'package:flutter/material.dart';
import 'package:temp_app_v1/screens/grid_screens/my_profile_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/settings_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColor.primary1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: MyColor.backgroundColor,
              ),
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: MyColor.backgroundColor,
            ),
            title: const Text(
              'Mój profil',
              style: TextStyle(
                fontSize: 18,
                color: MyColor.backgroundColor,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const MyProfileScreen())),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: MyColor.backgroundColor,
            ),
            title: const Text(
              'Ustawienia',
              style: TextStyle(
                fontSize: 18,
                color: MyColor.backgroundColor,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const SettingsScreen())),
              );
            },
          ),
        ],
      ),
    );
  }
}
