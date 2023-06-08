import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartCurve extends StatefulWidget {
  const LineChartCurve({super.key, required this.yValue});
  final yValue;

  @override
  State<LineChartCurve> createState() => _LineChartCurveState();
}

class _LineChartCurveState extends State<LineChartCurve> {
  final List<FlSpot> chartPoints = [];
  double xValue = 0;

  double step = 1;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      while (chartPoints.length > 100) {
        chartPoints.removeAt(0);
      }
      setState(() {
        chartPoints.add(FlSpot(xValue, widget.yValue));
      });
      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return chartPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                'x: ${xValue.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: Colors.black12,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'y: ${widget.yValue.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: Colors.black12,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: LineChart(
                    LineChartData(
                      minY: 15,
                      maxY: 43,
                      minX: chartPoints.first.x,
                      maxX: chartPoints.last.x,
                      lineTouchData: LineTouchData(enabled: false),
                      clipData: FlClipData.all(),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        curveLine(chartPoints),
                        curveLine(chartPoints),
                      ],
                      titlesData: FlTitlesData(show: false),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  LineChartBarData curveLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(show: false),
      barWidth: 4,
      isCurved: true,
    );
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
