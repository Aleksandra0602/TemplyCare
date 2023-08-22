import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

import '../../utils/methods/data_parser_method.dart';

class BatteryScreen extends StatefulWidget {
  BatteryScreen({Key? key, this.services}) : super(key: key);

  final List<BluetoothService>? services;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  double? currentBatteryValue = 0;
  String batteryValue = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == Dimensions.battery_serv_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                Dimensions.battery_level_uuid) {
              characteristic.value.listen((value) {
                setState(() {
                  widget.readValues[characteristic.uuid] = value;
                });
                batteryValue = dataParser(value);

                currentBatteryValue = double.parse(batteryValue);
              });
              characteristic.read();

              // characteristic.value.listen((value) {
              //   if (this.mounted) {
              //     setState(() {
              //       double? val = double.tryParse(dataParser(value));

              //       currentBatteryValue = val;
              //     });
              //     characteristic.read();
              //   }
              // });
            }
          });
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.buttonText3),
        backgroundColor: MyColor.primary3,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 350,
              decoration: BoxDecoration(
                color: MyColor.primary3,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: Get.isDarkMode
                    ? []
                    : [
                        const BoxShadow(
                          color: MyColor.shadow,
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Colors.grey.shade400,
                          disabledActiveTrackColor:
                              getBatteryColor(currentBatteryValue),
                          trackShape: const RectangularSliderTrackShape(),
                          trackHeight: 100,
                          thumbShape: SliderComponentShape.noThumb,
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 30,
                          ),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 250,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Slider(
                                value: currentBatteryValue ?? 0,
                                max: 100,
                                min: 0,
                                divisions: 100,
                                onChanged: null,
                                activeColor:
                                    getBatteryColor(currentBatteryValue),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.flash_on,
                          size: 50,
                          color: MyColor.additionalColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      currentBatteryValue == null
                          ? ''
                          : currentBatteryValue!.toStringAsFixed(0) + '%',
                      //'${batteryValue}%',
                      style: TextStyle(
                        fontSize: 28,
                        color: MyColor.backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              //alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.timeBattery,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    '8 h 32 min',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.batteryMessage,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Color? getBatteryColor(double? level) {
  if (level == null) {
    return Colors.amber;
  } else if (level <= 20.0) {
    return Colors.red;
  } else if (level > 20.0 && level <= 55.0) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}
