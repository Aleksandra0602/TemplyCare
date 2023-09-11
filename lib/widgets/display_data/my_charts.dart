import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class MyCharts extends StatelessWidget {
  const MyCharts({
    Key? key,
    required this.horizontalInterval,
    required this.context,
    required this.textLeftAxis,
    required this.interval,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.barDataList,
    required this.value1,
    required this.value2,
  }) : super(key: key);
  final double horizontalInterval;
  final BuildContext context;
  final String textLeftAxis;
  final double interval;
  final double maxX;
  final double minY;
  final double maxY;

  final List<LineChartBarData> barDataList;

  final String value1;
  final String value2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: horizontalInterval,
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
                      axisNameWidget: Text(textLeftAxis),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: interval,
                        reservedSize: 26,
                        getTitlesWidget: leftTempWidget,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(),
                      left: BorderSide(),
                    ),
                  ),
                  minX: 0,
                  maxX: maxX,
                  minY: minY,
                  maxY: maxY,
                  lineBarsData: barDataList,
                ),
                swapAnimationDuration: const Duration(seconds: 2),
              ),
            ),
          ),
        ),
        barDataList.length > 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "—",
                    style: TextStyle(
                      color: MyColor.additionalColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(value1),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "—",
                    style: TextStyle(
                      color: MyColor.additionalColor.withGreen(80),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(value2),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "—",
                    style: TextStyle(
                        color: MyColor.additionalColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(value1)
                ],
              ),
      ],
    );
  }

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
          axisPosition: 0,
          enabled: true),
      child: Text(value.toStringAsFixed(0)),
    );
  }
}
