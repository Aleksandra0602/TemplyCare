import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class MemoryCardScreen extends StatelessWidget {
  const MemoryCardScreen({Key? key}) : super(key: key);

  final double sdSize = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? MyColor.darkBackgroundColor.withRed(60).withBlue(60).withGreen(60)
          : MyColor.primary4,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.buttonText4),
        backgroundColor: MyColor.primary4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                size: 280,
                customColors: CustomSliderColors(
                  trackColor: MyColor.backgroundColor.withOpacity(0.8),
                  progressBarColors: [
                    MyColor.additionalColor,
                    MyColor.additionalColor.withGreen(90),
                  ],
                  shadowColor: MyColor.additionalColor,
                  shadowStep: 8,
                ),
                customWidths: CustomSliderWidths(
                  progressBarWidth: 18,
                  trackWidth: 12,
                  shadowWidth: 52,
                ),
                infoProperties: InfoProperties(
                  mainLabelStyle: TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.w200,
                      color: MyColor.backgroundColor,
                      shadows: const [
                        Shadow(
                          color: MyColor.shadow,
                          blurRadius: 8,
                          offset: Offset(1, 2),
                        ),
                      ]),
                  modifier: (double value) {
                    return '$sdSize%';
                  },
                ),
                angleRange: 360,
                startAngle: 270,
                animationEnabled: true,
              ),
              min: 0,
              max: 100,
              initialValue: sdSize,
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).backgroundColor,
                boxShadow: Get.isDarkMode
                    ? []
                    : [
                        const BoxShadow(
                          color: MyColor.shadow,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.memorySize,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? MyColor.backgroundColor
                              : MyColor.appBarColor1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '16 GB',
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? MyColor.backgroundColor
                              : MyColor.appBarColor1,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.usedMemory,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? MyColor.backgroundColor
                              : MyColor.appBarColor1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '1 GB (10%)',
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? MyColor.backgroundColor
                              : MyColor.appBarColor1,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.freeMemory,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? MyColor.backgroundColor
                              : MyColor.appBarColor1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '15 GB (90%)',
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? MyColor.backgroundColor
                              : MyColor.appBarColor1,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
