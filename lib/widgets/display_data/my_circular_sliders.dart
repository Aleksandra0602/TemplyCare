import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/scale_utils/scale_controller.dart';

class MyCircularSliders extends StatelessWidget {
  MyCircularSliders({
    Key? key,
    required this.trackWidth,
    required this.progressBarWidth,
    required this.shadowWidth,
    required this.displayedTemp,
    required this.textValue,
    required this.returnText,
    required this.startAngle,
    required this.angleRange,
    required this.size,
    required this.min,
    required this.max,
  }) : super(key: key);

  final ScaleController scaleController = Get.find();
  final double trackWidth;
  final double progressBarWidth;
  final double shadowWidth;
  final double displayedTemp;
  final String textValue;
  final String returnText;
  final double startAngle;
  final double angleRange;
  final double size;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        customColors: CustomSliderColors(
          trackColor: MyColor.primary1,
          progressBarColor: MyColor.primary1.withOpacity(0.5),
          shadowColor: Get.isDarkMode ? MyColor.primary4 : MyColor.primary2,
          shadowStep: 8,
        ),
        customWidths: CustomSliderWidths(
          trackWidth: trackWidth,
          progressBarWidth: progressBarWidth,
          shadowWidth: shadowWidth,
        ),
        infoProperties: InfoProperties(
            mainLabelStyle: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w200,
              color:
                  Get.isDarkMode ? MyColor.backgroundColor : MyColor.primary1,
            ),
            bottomLabelText: textValue,
            bottomLabelStyle: TextStyle(
              color: Get.isDarkMode ? MyColor.primary4 : MyColor.primary2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            modifier: (double value) {
              return returnText;
            }),
        startAngle: startAngle,
        angleRange: angleRange,
        size: size,
        animationEnabled: true,
      ),
      min: min,
      max: max,
      initialValue: displayedTemp,
    );
  }
}
