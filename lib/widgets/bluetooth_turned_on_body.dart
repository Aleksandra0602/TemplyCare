import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/paint.dart';

import 'modal_bottom.dart';

class BluetoothTurnedOnBody extends StatelessWidget {
  const BluetoothTurnedOnBody({
    Key? key,
    required this.firstRippleRadiusAnimation,
    required this.firstRippleOpacityAnimation,
    required this.firstRippleWidthAnimation,
    required this.secondRippleRadiusAnimation,
    required this.secondRippleOpacityAnimation,
    required this.secondRippleWidthAnimation,
    required this.thirdRippleRadiusAnimation,
    required this.thirdRippleOpacityAnimation,
    required this.thirdRippleWidthAnimation,
    required this.centerCircleRadiusAnimation,
  }) : super(key: key);

  final Animation<double> firstRippleRadiusAnimation;
  final Animation<double> firstRippleOpacityAnimation;
  final Animation<double> firstRippleWidthAnimation;
  final Animation<double> secondRippleRadiusAnimation;
  final Animation<double> secondRippleOpacityAnimation;
  final Animation<double> secondRippleWidthAnimation;
  final Animation<double> thirdRippleRadiusAnimation;
  final Animation<double> thirdRippleOpacityAnimation;
  final Animation<double> thirdRippleWidthAnimation;
  final Animation<double> centerCircleRadiusAnimation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CustomPaint(
              painter: MyPainter(
                firstRippleRadiusAnimation.value,
                firstRippleOpacityAnimation.value,
                firstRippleWidthAnimation.value,
                secondRippleRadiusAnimation.value,
                secondRippleOpacityAnimation.value,
                secondRippleWidthAnimation.value,
                thirdRippleRadiusAnimation.value,
                thirdRippleOpacityAnimation.value,
                thirdRippleWidthAnimation.value,
                centerCircleRadiusAnimation.value,
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  barrierColor: Colors.grey.withOpacity(0.2),
                  isDismissible: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  context: context,
                  backgroundColor: MyColor.appBarColor2,
                  builder: (context) {
                    return const ModalBottomBody();
                  },
                );
              },
              child: Icon(
                Icons.bluetooth,
                size: 60,
                color: MyColor.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
