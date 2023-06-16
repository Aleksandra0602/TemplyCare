import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/widgets/paint.dart';

import '../screens/log_sign_screen.dart';

class RippleAnimate extends StatefulWidget {
  const RippleAnimate({Key? key}) : super(key: key);

  @override
  _RippleAnimateState createState() => _RippleAnimateState();
}

class _RippleAnimateState extends State<RippleAnimate>
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
      backgroundColor: const Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('TemplyCare'),
        backgroundColor: const Color.fromRGBO(0, 25, 20, 0.8),
      ),
      body: Center(
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
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    context: context,
                    backgroundColor: const Color.fromRGBO(245, 255, 245, 1),
                    builder: (context) {
                      return const ModalBottomBody();
                    },
                  );
                },
                child: const Icon(
                  Icons.bluetooth,
                  size: 60,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModalBottomBody extends StatefulWidget {
  const ModalBottomBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ModalBottomBody> createState() => _ModalBottomBodyState();
}

class _ModalBottomBodyState extends State<ModalBottomBody> {
  final List<BluetoothDevice> devicesList = [];
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  late BluetoothCharacteristic characteristic;

  late Stream<List<int>> stream;

  BluetoothDevice? _connectedDevice;
  List<BluetoothService>? _services;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan(timeout: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: devicesList
            .map((element) => Card(
                  color: const Color.fromRGBO(245, 255, 245, 1),
                  shadowColor: const Color.fromRGBO(1, 100, 75, 0.8),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                element.name == ''
                                    ? 'Nieznane urządzenie'
                                    : element.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                element.id.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade800),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            flutterBlue.stopScan();
                            try {
                              await element.connect();
                            } catch (e) {
                              if (e.hashCode != 'already_connected') {
                                throw e;
                              }
                            } finally {
                              _services = await element.discoverServices();
                            }
                            setState(() {
                              _connectedDevice = element;
                              _services = _services;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        LogSignScreen(services: _services))));
                          },
                          child: Container(
                            height: 45,
                            width: 80,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(0, 60, 50, 1),
                            ),
                            child: const Center(
                              child: Text(
                                'Połącz',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
