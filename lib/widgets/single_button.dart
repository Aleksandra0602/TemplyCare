import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../utils/select_category_method.dart';
import 'screens.dart';

class SingleButton extends StatelessWidget {
  final String title;
  final Color color;

  final List<BluetoothService>? services;
  final ScreensEnum screens;

  const SingleButton(this.title, this.color, this.services, this.screens);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context, screens, services),
      splashColor: const Color.fromRGBO(25, 25, 25, 0.4),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
