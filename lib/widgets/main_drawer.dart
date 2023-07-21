import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:temp_app_v1/screens/grid_screens/my_profile_screen.dart';
import 'package:temp_app_v1/screens/grid_screens/settings_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/my_button.dart';

import '../screens/ripple_animate_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColor.primary2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MyColor.appBarColor1,
              MyColor.appBarColor2,
              MyColor.appBarColor3,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: MyColor.backgroundColor,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 150,
                    ),
                    GradientText(
                      "TemplyCare",
                      style: const TextStyle(
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: const [
                        MyColor.appBarColor1,
                        MyColor.appBarColor2,
                        MyColor.appBarColor3,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: MyColor.backgroundColor,
              ),
              title: Text(
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
              leading: Icon(
                Icons.settings,
                color: MyColor.backgroundColor,
              ),
              title: Text(
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RippleAnimateScreen()),
                    );
                  },
                  child: MyButton(
                    color: MyColor.additionalColor,
                    textButton: 'Wyloguj się',
                    borderColor: MyColor.additionalColor,
                    textColor: MyColor.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
