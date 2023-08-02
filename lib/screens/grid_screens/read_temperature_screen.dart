import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
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

  List<FlSpot> dataPoints = [];
  List<FlSpot> humPoints = [];
  FlSpot mostLeftSpot = FlSpot(0, 0);
  double xValue = 0;

  StreamSubscription<List<int>>? _dataSubscription;

  List<double> trace = [];
  late Stream<List<int>> stream;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

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

                  //temp2 = list[1]

                  hum = list[1];
                });
              });
              //TODO: przerobic na metode, ktora bedzie zwracac obiekt characteristic
              //ktory bedziemy wykorzystywac w StreamBuilderze jako strumien
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
    dataPoints.add(FlSpot(dataPoints.length.toDouble(), data));
    if (dataPoints.length > 15) {
      print(dataPoints);
      dataPoints.removeAt(0);
      for (int i = 0; i < dataPoints.length; i++) {
        dataPoints[i] = FlSpot(dataPoints[i].x - 1, dataPoints[i].y);
      }
    }

    xValue += 1;
  }

  Widget leftTitleWidget(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 20:
        text = '20';
        break;
      case 22:
        text = '22';
        break;
      case 24:
        text = '24';
        break;
      case 26:
        text = '26';
        break;
      case 28:
        text = '28';
        break;
      default:
        return Container();
    }

    return Text(text, textAlign: TextAlign.center);
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
                    trackColor: MyColor.primary1,
                    progressBarColor: MyColor.primary1.withOpacity(0.5),
                    shadowColor: MyColor.primary2,
                    shadowStep: 8,
                  ),
                  customWidths: CustomSliderWidths(
                    trackWidth: 4,
                    progressBarWidth: 10,
                    shadowWidth: 40,
                  ),
                  infoProperties: InfoProperties(
                      bottomLabelText: 'Temperatura 1',
                      bottomLabelStyle: const TextStyle(
                        color: MyColor.primary2,
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
                    trackColor: MyColor.primary1,
                    progressBarColor: MyColor.primary1.withOpacity(0.5),
                    shadowColor: MyColor.primary2,
                    shadowStep: 8,
                  ),
                  customWidths: CustomSliderWidths(
                    trackWidth: 3,
                    progressBarWidth: 10,
                    shadowWidth: 40,
                  ),
                  infoProperties: InfoProperties(
                      bottomLabelText: 'Poziom wilgotności',
                      bottomLabelStyle: const TextStyle(
                        color: MyColor.primary2,
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
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: MyColor.shadow,
                          spreadRadius: 2,
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      gradient: LinearGradient(
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
                          'Wykres temperatury',
                          style: TextStyle(
                              color: MyColor.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Ostatnie 15 pomiarów',
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
                            color: MyColor.backgroundColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
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
                                borderRadius: BorderRadius.circular(15),
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
                                          showTitles: false,
                                          reservedSize: 28,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 2,
                                          reservedSize: 32,
                                          getTitlesWidget: leftTitleWidget,
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
                                    minY: 20,
                                    maxY: 28,
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
                          'Wykres wilgotności',
                          style: TextStyle(
                              color: MyColor.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Ostatnie 15 pomiarów',
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
                            color: MyColor.backgroundColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
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
                                borderRadius: BorderRadius.circular(15),
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      horizontalInterval: 25,
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
                                          showTitles: false,
                                          reservedSize: 28,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 25,
                                          reservedSize: 32,
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
                                    minY: 0,
                                    maxY: 100,
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
