import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

import '../../utils/data_parser_method.dart';

class ReadTemperatureScreen extends StatefulWidget {
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  ReadTemperatureScreen({super.key, required this.services});

  final List<BluetoothService>? services;

  @override
  State<ReadTemperatureScreen> createState() => _ReadTemperatureScreenState();
}

class _ReadTemperatureScreenState extends State<ReadTemperatureScreen> {
  String warunek = '1,0,0';
  double temp = 0;
  double temp2 = 0;
  double hum = 0;
  double temp1 = 5;

  List<double> trace = [];
  late Stream<List<int>> stream;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();
  late StreamSubscription<List<int>> subscription;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == Dimensions.service_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                Dimensions.characteristic_uuid) {
              print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
              print(service.uuid);

              characteristic.setNotifyValue(!characteristic.isNotifying);

              subscription = characteristic.value.listen((value) {
                print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
                List<double> list =
                    dataParser(value).split(',').map<double>((e) {
                  return double.parse(e);
                }).toList();

                if (this.mounted) {
                  setState(() {
                    print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                    temp = list[0];
                    //temp2 = list[1]

                    hum = list[1];
                  });
                }
              });
            }
          });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Aktualne pomiary'),
        backgroundColor: MyColor.primary1,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customColors: CustomSliderColors(
                    trackColor: const Color.fromRGBO(0, 70, 70, 1),
                    progressBarColor: const Color.fromRGBO(0, 75, 70, 0.5),
                    shadowColor: const Color.fromRGBO(0, 75, 70, 0.5),
                    shadowStep: 10,
                  ),
                  customWidths: CustomSliderWidths(
                    trackWidth: 5,
                    progressBarWidth: 10,
                    shadowWidth: 40,
                  ),
                  infoProperties: InfoProperties(
                      bottomLabelText: 'Temperatura 1',
                      bottomLabelStyle: const TextStyle(
                        color: Color.fromRGBO(1, 90, 70, 0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      modifier: (double value) {
                        return '${temp} ˚C';
                      }),
                  startAngle: 180,
                  angleRange: 180,
                  size: 250,
                  animationEnabled: true,
                ),
                min: 0,
                max: 45,
                initialValue: temp,
              ),
              const SizedBox(
                height: 12,
              ),
              // SleekCircularSlider(
              //   appearance: CircularSliderAppearance(
              //     customColors: CustomSliderColors(
              //       trackColor: Color.fromRGBO(0, 70, 70, 1),
              //       progressBarColor: Color.fromRGBO(0, 75, 70, 0.5),
              //       shadowColor: Color.fromRGBO(0, 75, 70, 0.5),
              //       shadowStep: 10,
              //     ),
              //     customWidths: CustomSliderWidths(
              //       trackWidth: 3,
              //       progressBarWidth: 15,
              //       shadowWidth: 30,
              //     ),
              //     infoProperties: InfoProperties(
              //         bottomLabelText: 'Temperatura 2',
              //         bottomLabelStyle: TextStyle(
              //           color: Color.fromRGBO(1, 90, 70, 0.8),
              //           fontSize: 20,
              //         ),
              //         modifier: (double value) {
              //           return '${temp2} ˚C';
              //         }),
              //     startAngle: 180,
              //     angleRange: 180,
              //     size: 200,
              //     animationEnabled: true,
              //   ),
              //   min: 20,
              //   max: 45,
              //   initialValue: temp2,
              // ),
              const SizedBox(
                height: 12,
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customColors: CustomSliderColors(
                    trackColor: const Color.fromRGBO(0, 70, 70, 1),
                    progressBarColor: const Color.fromRGBO(0, 75, 70, 0.5),
                    shadowColor: const Color.fromRGBO(0, 75, 70, 0.5),
                    shadowStep: 10,
                  ),
                  customWidths: CustomSliderWidths(
                    trackWidth: 3,
                    progressBarWidth: 10,
                    shadowWidth: 40,
                  ),
                  infoProperties: InfoProperties(
                      bottomLabelText: 'Poziom wilgotności',
                      bottomLabelStyle: const TextStyle(
                        color: Color.fromRGBO(1, 90, 70, 0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      modifier: (double value) {
                        return '$hum %';
                      }),
                  startAngle: 135,
                  angleRange: 270,
                  size: 230,
                  animationEnabled: true,
                ),
                min: 0,
                max: 100,
                initialValue: hum,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
