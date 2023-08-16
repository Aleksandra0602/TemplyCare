import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/scale_controller.dart';

import '../../utils/data_parser_method.dart';

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
  double temp1 = 5;

  List<FlSpot> dataPoints = [];
  List<FlSpot> humPoints = [];
  List<FlSpot> dataPoints2 = [];
  FlSpot mostLeftSpot = FlSpot(0, 0);
  double xValue = 0;
  double xValueH = 0;

  StreamSubscription<List<int>>? _dataSubscription;

  List<double> trace = [];
  late Stream<List<int>> stream;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontSize: 10,
      color: Theme.of(context).backgroundColor,
    );
    Widget text;
    if (value.toInt() <= 15) {
      text = Text(
        value.toInt().toString(),
        style: style,
      );
    } else {
      text = Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      fitInside: const SideTitleFitInsideData(
          distanceFromEdge: 0,
          parentAxisSize: 4,
          axisPosition: 0,
          enabled: true),
      child: text,
    );
  }

  Widget leftTempWidget(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      fitInside: const SideTitleFitInsideData(
          distanceFromEdge: 0,
          parentAxisSize: 2,
          axisPosition: 0.5,
          enabled: true),
      child: Text(value.toInt().toString()),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == Dimensions.service_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                Dimensions.characteristic_uuid) {
              characteristic.setNotifyValue(!characteristic.isNotifying);
              _dataSubscription = characteristic.value.listen((value) {
                List<double> list =
                    dataParser(value).split(',').map<double>((e) {
                  return double.parse(e);
                }).toList();

                setState(() {
                  temp = list[0];
                  addDataPoint(temp);

                  temp2 = list[1];
                  addDataPoint2(temp2);

                  hum = list[2];
                  addHumPoint(hum);
                });
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
    _dataSubscription?.cancel();
    super.dispose();
  }

  void addDataPoint(double data) {
    dataPoints
        .add(FlSpot(dataPoints.length.toDouble(), convertCelsiusToFah(data)));
    if (dataPoints.length > 15) {
      dataPoints.removeAt(0);
      for (int i = 0; i < dataPoints.length; i++) {
        dataPoints[i] = FlSpot(dataPoints[i].x - 1, dataPoints[i].y);
      }
    }

    xValue += 1;
  }

  void addDataPoint2(double data) {
    dataPoints2
        .add(FlSpot(dataPoints.length.toDouble(), convertCelsiusToFah(data)));
    if (dataPoints2.length > 15) {
      dataPoints2.removeAt(0);
      for (int i = 0; i < dataPoints2.length; i++) {
        dataPoints2[i] = FlSpot(dataPoints2[i].x - 1, dataPoints2[i].y);
      }
    }

    xValue += 1;
  }

  void addHumPoint(double data) {
    humPoints.add(FlSpot(humPoints.length.toDouble(), data));
    if (humPoints.length > 15) {
      humPoints.removeAt(0);
      for (int i = 0; i < humPoints.length; i++) {
        humPoints[i] = FlSpot(humPoints[i].x - 1, humPoints[i].y);
      }
    }

    xValueH += 1;
  }

  double _calculateMinY(List<FlSpot> points, double x, double y) {
    double minValue = y;
    for (var point in points) {
      if (point.y < minValue) {
        minValue = point.y;
      }
    }
    return minValue - x; // Dodatkowy margines
  }

  double _calculateMaxY(List<FlSpot> points, double x, double y) {
    double maxValue = y;
    for (var point in points) {
      if (point.y > maxValue) {
        maxValue = point.y;
      }
    }
    return maxValue + x; // Dodatkowy margines
  }

  double _calculateMinYT(
      List<FlSpot> points, List<FlSpot> points2, double x, double y) {
    double minDataPoints1 =
        points.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    double minDataPoints2 =
        points2.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    double minValue =
        minDataPoints1 < minDataPoints2 ? minDataPoints1 : minDataPoints2;

    for (var point in points) {
      if (point.y < minValue) {
        minValue = point.y;
      }
    }
    for (var point in points2) {
      if (point.y < minValue) {
        minValue = point.y;
      }
    }
    return minValue - x - y; // Dodatkowy margines
  }

  double _calculateMaxYT(
      List<FlSpot> points, List<FlSpot> points2, double x, double y) {
    double maxDataPoints1 =
        points.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    double maxDataPoints2 =
        points2.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);

    double maxValue =
        maxDataPoints1 > maxDataPoints2 ? maxDataPoints1 : maxDataPoints2;

    for (var point in points) {
      if (point.y > maxValue) {
        maxValue = point.y;
      }
    }
    for (var point in points2) {
      if (point.y > maxValue) {
        maxValue = point.y;
      }
    }
    return maxValue + x + y; // Dodatkowy margines
  }

  double convertCelsiusToFah(double temperature) {
    return scaleController.isCelsius ? temperature : (temperature * 9 / 5) + 32;
  }

  @override
  Widget build(BuildContext context) {
    double displayedTemp = convertCelsiusToFah(temp);
    double displayedTemp2 = convertCelsiusToFah(temp2);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.secondAppBar),
        backgroundColor: MyColor.primary1,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customColors: CustomSliderColors(
                    trackColor: MyColor.primary1,
                    progressBarColor: MyColor.primary1.withOpacity(0.5),
                    shadowColor:
                        Get.isDarkMode ? MyColor.primary4 : MyColor.primary2,
                    shadowStep: 8,
                  ),
                  customWidths: CustomSliderWidths(
                    trackWidth: 4,
                    progressBarWidth: 12,
                    shadowWidth: 40,
                  ),
                  infoProperties: InfoProperties(
                      mainLabelStyle: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w200,
                        color: Get.isDarkMode
                            ? MyColor.backgroundColor
                            : MyColor.primary1,
                      ),
                      bottomLabelText: AppLocalizations.of(context)!.tempValue1,
                      bottomLabelStyle: TextStyle(
                        color: Get.isDarkMode
                            ? MyColor.primary4
                            : MyColor.primary2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      modifier: (double value) {
                        return '$displayedTemp ${scaleController.isCelsius ? '˚C' : '˚F'}';
                      }),
                  startAngle: 180,
                  angleRange: 180,
                  size: 250,
                  animationEnabled: true,
                ),
                min: convertCelsiusToFah(0),
                max: convertCelsiusToFah(45),
                initialValue: displayedTemp,
              ),
              const SizedBox(
                height: 6,
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customColors: CustomSliderColors(
                    trackColor: MyColor.primary1,
                    progressBarColor: MyColor.primary1.withOpacity(0.5),
                    shadowColor:
                        Get.isDarkMode ? MyColor.primary4 : MyColor.primary2,
                    shadowStep: 8,
                  ),
                  customWidths: CustomSliderWidths(
                    trackWidth: 4,
                    progressBarWidth: 12,
                    shadowWidth: 40,
                  ),
                  infoProperties: InfoProperties(
                      mainLabelStyle: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w200,
                        color: Get.isDarkMode
                            ? MyColor.backgroundColor
                            : MyColor.primary1,
                      ),
                      bottomLabelText: AppLocalizations.of(context)!.tempValue2,
                      bottomLabelStyle: TextStyle(
                        color: Get.isDarkMode
                            ? MyColor.primary4
                            : MyColor.primary2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      modifier: (double value) {
                        return '$displayedTemp2 ${scaleController.isCelsius ? '˚C' : '˚F'}';
                      }),
                  startAngle: 180,
                  angleRange: 180,
                  size: 250,
                  animationEnabled: true,
                ),
                min: convertCelsiusToFah(0),
                max: convertCelsiusToFah(45),
                initialValue: displayedTemp2,
              ),
              const SizedBox(
                height: 6,
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customColors: CustomSliderColors(
                    trackColor: MyColor.primary1,
                    progressBarColor: MyColor.primary1.withOpacity(0.5),
                    shadowColor:
                        Get.isDarkMode ? MyColor.primary4 : MyColor.primary2,
                    shadowStep: 8,
                  ),
                  customWidths: CustomSliderWidths(
                    trackWidth: 3,
                    progressBarWidth: 10,
                    shadowWidth: 40,
                  ),
                  infoProperties: InfoProperties(
                      mainLabelStyle: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w200,
                        color: Get.isDarkMode
                            ? MyColor.backgroundColor
                            : MyColor.primary1,
                      ),
                      bottomLabelText: AppLocalizations.of(context)!.humValue,
                      bottomLabelStyle: TextStyle(
                        color: Get.isDarkMode
                            ? MyColor.primary4
                            : MyColor.primary2,
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
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      boxShadow: Get.isDarkMode
                          ? []
                          : [
                              const BoxShadow(
                                color: MyColor.shadow,
                                spreadRadius: 2,
                                blurRadius: 6,
                              ),
                            ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          MyColor.primary1,
                          MyColor.primary3,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.tempChart,
                          style: TextStyle(
                              color: MyColor.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          AppLocalizations.of(context)!.last15,
                          style: TextStyle(
                            color: MyColor.backgroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          height: 190,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: Get.isDarkMode
                                ? []
                                : [
                                    const BoxShadow(
                                      color: MyColor.shadow,
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                    ),
                                  ],
                          ),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      horizontalInterval: 1,
                                      verticalInterval: 1,
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 12,
                                          interval: 4,
                                          getTitlesWidget: bottomTitleWidgets,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        axisNameWidget: Text(
                                            scaleController.isCelsius
                                                ? 'T [˚C]'
                                                : 'T [˚F]'),
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: scaleController.isCelsius
                                              ? 6
                                              : 10,
                                          reservedSize: 26,
                                          getTitlesWidget: leftTempWidget,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                          bottom: BorderSide(),
                                          left: BorderSide()),
                                    ),
                                    minX: 0,
                                    maxX: dataPoints.length + 2,
                                    minY: scaleController.isCelsius
                                        ? _calculateMinY(dataPoints, 0.5, 40)
                                        : _calculateMinY(dataPoints, 4, 95),
                                    maxY: scaleController.isCelsius
                                        ? _calculateMaxY(dataPoints, 0.5, 20)
                                        : _calculateMaxY(dataPoints, 4, 50),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: dataPoints,
                                        isCurved: true,
                                        color: MyColor.additionalColor,
                                        dotData: FlDotData(show: false),
                                        belowBarData: BarAreaData(
                                          show: true,
                                        ),
                                        barWidth: 2,
                                      ),
                                      LineChartBarData(
                                        spots: dataPoints2,
                                        isCurved: true,
                                        color: MyColor.additionalColor
                                            .withGreen(90),
                                        dotData: FlDotData(show: false),
                                        belowBarData: BarAreaData(
                                          show: true,
                                        ),
                                        barWidth: 2,
                                      ),
                                    ],
                                  ),
                                  swapAnimationDuration:
                                      const Duration(seconds: 2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!.humChart,
                          style: TextStyle(
                              color: MyColor.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          AppLocalizations.of(context)!.last15,
                          style: TextStyle(
                            color: MyColor.backgroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          height: 200,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: Get.isDarkMode
                                ? []
                                : [
                                    const BoxShadow(
                                      color: MyColor.shadow,
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                    ),
                                  ],
                          ),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      horizontalInterval: 5,
                                      verticalInterval: 1,
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 12,
                                          getTitlesWidget: bottomTitleWidgets,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        axisNameWidget: Text('W [%]'),
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 25,
                                          reservedSize: 26,
                                          getTitlesWidget: leftTempWidget,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                          bottom: BorderSide(),
                                          left: BorderSide()),
                                    ),
                                    minX: 0,
                                    maxX: humPoints.length + 2,
                                    minY: _calculateMinY(humPoints, 5, 60),
                                    maxY: _calculateMaxY(humPoints, 5, 40),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: humPoints,
                                        isCurved: true,
                                        color: MyColor.additionalColor,
                                        dotData: FlDotData(show: false),
                                        belowBarData: BarAreaData(
                                          show: true,
                                        ),
                                        barWidth: 2,
                                      ),
                                    ],
                                  ),
                                  swapAnimationDuration:
                                      const Duration(seconds: 2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
