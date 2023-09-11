import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/loading_widget.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/methods/data_processing_utils.dart';
import 'package:temp_app_v1/utils/scale_utils/scale_controller.dart';

import 'package:temp_app_v1/widgets/display_data/chart_container.dart';

import 'package:temp_app_v1/widgets/display_data/my_circular_sliders.dart';

import '../../utils/methods/data_parser_method.dart';

class ReadTemperatureScreen extends StatefulWidget {
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  ReadTemperatureScreen({super.key, required this.services});

  final List<BluetoothService>? services;

  @override
  State<ReadTemperatureScreen> createState() => _ReadTemperatureScreenState();
}

class _ReadTemperatureScreenState extends State<ReadTemperatureScreen> {
  final ScaleController scaleController = Get.find();

  double temp = 0;
  double temp2 = 0;
  double hum = 0;

  List<FlSpot> dataPoints = [];
  List<FlSpot> humPoints = [];
  List<FlSpot> dataPoints2 = [];
  double xValue = 0;
  double xValueH = 0;
  bool showMe = false;

  StreamSubscription<List<int>>? _dataSubscription;

  List<double> trace = [];
  late Stream<List<int>> stream;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  void fetchData() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == Dimensions.service_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                Dimensions.characteristic_uuid) {
              characteristic.setNotifyValue(true);
              _dataSubscription = characteristic.value.listen((value) {
                List<double> list =
                    dataParser(value).split(',').map<double>((e) {
                  return double.parse(e);
                }).toList();

                setState(() {
                  temp = list[0];
                  DataProcessingUtils.addDataPoint(
                      dataPoints, temp, xValue, scaleController.isCelsius);

                  temp2 = list[1];
                  DataProcessingUtils.addDataPoint(
                      dataPoints2, temp2, xValue, scaleController.isCelsius);

                  hum = list[2];
                  DataProcessingUtils.addDataPoint(
                      humPoints, hum, xValueH, scaleController.isCelsius);
                  showMe = true;
                });
              });
            }
          });
        }
      });
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _dataSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayedTemp = DataProcessingUtils.convertCelsiusToFah(
        temp, scaleController.isCelsius);
    double displayedTemp2 = DataProcessingUtils.convertCelsiusToFah(
        temp2, scaleController.isCelsius);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.secondAppBar),
        backgroundColor: MyColor.primary1,
      ),
      body: showMe
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    MyCircularSliders(
                      trackWidth: 4,
                      progressBarWidth: 12,
                      shadowWidth: 40,
                      displayedTemp: displayedTemp,
                      textValue: AppLocalizations.of(context)!.tempValue1,
                      returnText:
                          '$displayedTemp ${scaleController.isCelsius ? '˚C' : '˚F'}',
                      startAngle: 180,
                      angleRange: 180,
                      size: 250,
                      min: DataProcessingUtils.convertCelsiusToFah(
                          0, scaleController.isCelsius),
                      max: DataProcessingUtils.convertCelsiusToFah(
                          45, scaleController.isCelsius),
                    ),
                    MyCircularSliders(
                      trackWidth: 4,
                      progressBarWidth: 12,
                      shadowWidth: 40,
                      displayedTemp: displayedTemp2,
                      textValue: AppLocalizations.of(context)!.tempValue2,
                      returnText:
                          '$displayedTemp2 ${scaleController.isCelsius ? '˚C' : '˚F'}',
                      startAngle: 180,
                      angleRange: 180,
                      size: 250,
                      min: DataProcessingUtils.convertCelsiusToFah(
                          0, scaleController.isCelsius),
                      max: DataProcessingUtils.convertCelsiusToFah(
                          45, scaleController.isCelsius),
                    ),
                    MyCircularSliders(
                      trackWidth: 3,
                      progressBarWidth: 10,
                      shadowWidth: 40,
                      displayedTemp: hum,
                      textValue: AppLocalizations.of(context)!.humValue,
                      returnText: '$hum %',
                      startAngle: 135,
                      angleRange: 270,
                      size: 230,
                      min: 0,
                      max: 100,
                    ),
                    ChartContainer(
                      dataPoints: dataPoints,
                      humPoints: humPoints,
                      dataPoints2: dataPoints2,
                      showMe: showMe,
                    ),
                  ],
                ),
              ),
            )
          : const LoadingWidget(),
    );
  }
}
