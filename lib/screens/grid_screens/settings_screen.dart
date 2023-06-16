import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Ustawienia'),
        backgroundColor: const Color.fromRGBO(0, 140, 130, 1),
      ),
    );
  }
}
