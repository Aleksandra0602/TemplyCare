import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/utils/constans/my_color.dart';

import '../widgets/bluetooth_turned_on_body.dart';
import '../widgets/bt_alert_dialog.dart';

class RippleAnimateScreen extends StatefulWidget {
  const RippleAnimateScreen({Key? key}) : super(key: key);

  @override
  _RippleAnimateState createState() => _RippleAnimateState();
}

class _RippleAnimateState extends State<RippleAnimateScreen>
    with TickerProviderStateMixin {
  late AnimationController firstRippleController;
  late AnimationController secondRippleController;
  late AnimationController thirdRippleController;
  late AnimationController centerCircleController;
  late Animation<double> firstRippleRadiusAnimation;
  late Animation<double> firstRippleOpacityAnimation;
  late Animation<double> firstRippleWidthAnimation;
  late Animation<double> secondRippleRadiusAnimation;
  late Animation<double> secondRippleOpacityAnimation;
  late Animation<double> secondRippleWidthAnimation;
  late Animation<double> thirdRippleRadiusAnimation;
  late Animation<double> thirdRippleOpacityAnimation;
  late Animation<double> thirdRippleWidthAnimation;
  late Animation<double> centerCircleRadiusAnimation;

  @override
  void initState() {
    firstRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    firstRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          firstRippleController.forward();
        }
      });

    firstRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    firstRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    secondRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    secondRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          secondRippleController.forward();
        }
      });

    secondRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    secondRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    thirdRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    thirdRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          thirdRippleController.forward();
        }
      });

    thirdRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    thirdRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    centerCircleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    centerCircleRadiusAnimation = Tween<double>(begin: 50, end: 65).animate(
      CurvedAnimation(
        parent: centerCircleController,
        curve: Curves.fastOutSlowIn,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            centerCircleController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            centerCircleController.forward();
          }
        },
      );

    firstRippleController.forward();
    Timer(
      const Duration(milliseconds: 765),
      () => secondRippleController.forward(),
    );

    Timer(
      const Duration(milliseconds: 1050),
      () => thirdRippleController.forward(),
    );

    centerCircleController.forward();

    super.initState();
  }

  final List<BluetoothDevice> devicesList = [];
  late BluetoothCharacteristic characteristic;

  late Stream<List<int>> stream;
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  void dispose() {
    firstRippleController.dispose();
    secondRippleController.dispose();
    thirdRippleController.dispose();
    centerCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => SystemNavigator.pop(),
          icon: const Icon(Icons.exit_to_app),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('TemplyCare'),
        backgroundColor: MyColor.appBarColor1,
      ),
      body: StreamBuilder<BluetoothState>(
        stream: FlutterBluePlus.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;

          if (state == BluetoothState.on) {
            return BluetoothTurnedOnBody(
              firstRippleRadiusAnimation: firstRippleRadiusAnimation,
              firstRippleOpacityAnimation: firstRippleOpacityAnimation,
              firstRippleWidthAnimation: firstRippleWidthAnimation,
              secondRippleRadiusAnimation: secondRippleRadiusAnimation,
              secondRippleOpacityAnimation: secondRippleOpacityAnimation,
              secondRippleWidthAnimation: secondRippleWidthAnimation,
              thirdRippleRadiusAnimation: thirdRippleRadiusAnimation,
              thirdRippleOpacityAnimation: thirdRippleOpacityAnimation,
              thirdRippleWidthAnimation: thirdRippleWidthAnimation,
              centerCircleRadiusAnimation: centerCircleRadiusAnimation,
            );
          } else {
            return BluetoothAlertDialog();
          }
        },
      ),
    );
  }
}