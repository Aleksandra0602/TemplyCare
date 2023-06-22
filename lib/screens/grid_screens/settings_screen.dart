import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Ustawienia'),
        backgroundColor: MyColor.primary7,
      ),
    );
  }
}
