import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/constans/screens.dart';
import 'package:temp_app_v1/widgets/category_buttons/category_button_square.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key, required this.services}) : super(key: key);
  final List<BluetoothService>? services;

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  @override
  Widget build(BuildContext context) {
    final double widthSquare = MediaQuery.of(context).size.width / 2 - 12.0;
    final double widthRectangle = MediaQuery.of(context).size.width - 12.0;
    final double height = MediaQuery.of(context).size.height / 5;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('TemplyCare'),
        backgroundColor: MyColor.appBarColor2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButtonSquare(
                  title: AppLocalizations.of(context)!.buttonText1,
                  color: MyColor.primary1,
                  screens: ScreensEnum.realTemperatureScreen,
                  services: widget.services,
                  width: widthSquare,
                  height: widthSquare,
                ),
                CategoryButtonSquare(
                  title: AppLocalizations.of(context)!.buttonText2,
                  color: MyColor.primary2,
                  screens: ScreensEnum.measurementScreen,
                  services: widget.services,
                  width: widthSquare,
                  height: widthSquare,
                )
              ],
            ),
            CategoryButtonSquare(
              title: AppLocalizations.of(context)!.buttonText4,
              color: MyColor.primary3,
              screens: ScreensEnum.memoryCardScreen,
              services: widget.services,
              width: widthRectangle,
              height: height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButtonSquare(
                  title: AppLocalizations.of(context)!.buttonText3,
                  color: MyColor.primary4,
                  screens: ScreensEnum.batteryScreen,
                  services: widget.services,
                  width: widthSquare,
                  height: widthSquare,
                ),
                CategoryButtonSquare(
                  title: AppLocalizations.of(context)!.buttonText5,
                  color: MyColor.primary5,
                  screens: ScreensEnum.displayFilesScreen,
                  services: widget.services,
                  width: widthSquare,
                  height: widthSquare,
                ),
              ],
            ),
            CategoryButtonSquare(
              title: AppLocalizations.of(context)!.buttonText6,
              color: MyColor.primary6,
              screens: ScreensEnum.timeDeviceScreen,
              services: widget.services,
              width: widthRectangle,
              height: height,
            ),
          ],
        ),
      ),
    );
  }
}
