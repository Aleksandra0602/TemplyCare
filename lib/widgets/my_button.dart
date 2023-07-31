import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.color,
    required this.textButton,
    required this.borderColor,
    required this.textColor,
  });

  final Color color;
  final String textButton;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 52),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 3, color: borderColor),
          color: color,
          boxShadow: const [
            BoxShadow(
                color: MyColor.shadow,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Center(
          child: Text(
            textButton,
            style: TextStyle(
                color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
