import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temp_app_v1/utils/methods/data_processing_utils.dart';
import 'package:temp_app_v1/utils/scale_utils/scale_controller.dart';
import 'package:temp_app_v1/widgets/display_data/my_charts.dart';

class ChartContainer extends StatelessWidget {
  ChartContainer(
      {Key? key,
      required this.dataPoints,
      required this.humPoints,
      required this.dataPoints2,
      required this.showMe})
      : super(key: key);
  final List<FlSpot> dataPoints;
  final List<FlSpot> humPoints;
  final List<FlSpot> dataPoints2;

  final ScaleController scaleController = Get.find();
  final bool showMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                child: SingleChildScrollView(
                  child: MyCharts(
                    horizontalInterval: 1,
                    context: context,
                    textLeftAxis:
                        scaleController.isCelsius ? 'T [˚C]' : 'T [˚F]',
                    interval: scaleController.isCelsius ? 6 : 10,
                    maxX: dataPoints.length + 2,
                    minY: scaleController.isCelsius
                        ? DataProcessingUtils.calculateMinYT(
                            dataPoints, dataPoints2, 0.5, 40)
                        : DataProcessingUtils.calculateMinYT(
                            dataPoints, dataPoints2, 4, 95),
                    maxY: scaleController.isCelsius
                        ? DataProcessingUtils.calculateMaxYT(
                            dataPoints, dataPoints2, 0.5, 20)
                        : DataProcessingUtils.calculateMaxYT(
                            dataPoints, dataPoints2, 4, 50),
                    barDataList: [
                      LineChartBarData(
                        spots: dataPoints,
                        show: showMe,
                        isCurved: true,
                        color: MyColor.additionalColor,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: true),
                        barWidth: 2,
                      ),
                      LineChartBarData(
                        spots: dataPoints2,
                        show: showMe,
                        isCurved: true,
                        color: MyColor.additionalColor.withGreen(80),
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: true),
                        barWidth: 2,
                      ),
                    ],
                    Value1: AppLocalizations.of(context)!.tempValue1,
                    Value2: AppLocalizations.of(context)!.tempValue2,
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
                child: SingleChildScrollView(
                  child: MyCharts(
                    horizontalInterval: 5,
                    context: context,
                    textLeftAxis: 'W [%]',
                    interval: 25,
                    maxX: humPoints.length + 2,
                    minY: DataProcessingUtils.calculateMinY(humPoints, 5, 60),
                    maxY: DataProcessingUtils.calculateMaxY(humPoints, 5, 40),
                    barDataList: [
                      LineChartBarData(
                        spots: humPoints,
                        isCurved: true,
                        show: showMe,
                        color: MyColor.additionalColor,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                        ),
                        barWidth: 2,
                      ),
                    ],
                    Value1: AppLocalizations.of(context)!.humValue,
                    Value2: AppLocalizations.of(context)!.humValue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
