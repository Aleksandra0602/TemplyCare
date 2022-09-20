import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../utils/select_category_method.dart';
import 'screens.dart';

class SingleButton extends StatelessWidget {
  final String title;
  final Color color;

  final List<BluetoothService>? services;
  final ScreensEnum screens;

  SingleButton(this.title, this.color, this.services, this.screens);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context, screens, services),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
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
