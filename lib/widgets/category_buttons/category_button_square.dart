import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:temp_app_v1/utils/constans/screens.dart';
import 'package:temp_app_v1/utils/select_category_method.dart';

import '../../utils/constans/my_color.dart';

class CategoryButtonSquare extends StatelessWidget {
  final String title;
  final Color color;
  final Color color2;
  final List<BluetoothService>? services;
  final ScreensEnum screens;
  final double width;
  final double height;

  const CategoryButtonSquare({
    Key? key,
    required this.title,
    required this.color,
    required this.color2,
    required this.services,
    required this.screens,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context, screens, services),
      splashColor: MyColor.shadow,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color2,
            ],
          ),
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: Get.isDarkMode
              ? []
              : const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
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
