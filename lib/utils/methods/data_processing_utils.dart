import 'package:fl_chart/fl_chart.dart';

class DataProcessingUtils {
  static void addDataPoint(
      List<FlSpot> dataPoints, double data, double xValue, bool isCelsius) {
    dataPoints.add(
      FlSpot(
        dataPoints.length.toDouble(),
        convertCelsiusToFah(data, isCelsius),
      ),
    );
    if (dataPoints.length > 15) {
      dataPoints.removeAt(0);
      for (int i = 0; i < dataPoints.length; i++) {
        dataPoints[i] = FlSpot(dataPoints[i].x - 1, dataPoints[i].y);
      }
    }

    xValue += 1;
  }

  static double calculateMinY(List<FlSpot> points, double x, double y) {
    double minValue = y;
    for (var point in points) {
      if (point.y < minValue) {
        minValue = point.y;
      }
    }
    return minValue - x; // Dodatkowy margines
  }

  static double calculateMaxY(List<FlSpot> points, double x, double y) {
    double maxValue = y;
    for (var point in points) {
      if (point.y > maxValue) {
        maxValue = point.y;
      }
    }
    return maxValue + x; // Dodatkowy margines
  }

  static double calculateMinYT(
      List<FlSpot> points, List<FlSpot> points2, double x, double y) {
    double minValue = y;
    double minValue2 = y;

    for (var point in points) {
      if (point.y < minValue) {
        minValue = point.y;
      }
    }
    for (var point in points2) {
      if (point.y < minValue) {
        minValue2 = point.y;
      }
    }
    return minValue < minValue2
        ? minValue - x
        : minValue2 - x; // Dodatkowy margines
  }

  static double calculateMaxYT(
      List<FlSpot> points, List<FlSpot> points2, double x, double y) {
    double maxValue = y;
    double maxValue2 = y;

    for (var point in points) {
      if (point.y > maxValue) {
        maxValue = point.y;
      }
    }
    for (var point in points2) {
      if (point.y > maxValue) {
        maxValue2 = point.y;
      }
    }
    return maxValue > maxValue2
        ? maxValue + x
        : maxValue2 + x; // Dodatkowy margines
  }

  static double convertCelsiusToFah(double temperature, bool isCelsius) {
    return isCelsius ? temperature : (temperature * 9 / 5) + 32;
  }
}
