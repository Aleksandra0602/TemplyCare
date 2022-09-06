import 'package:flutter/material.dart';

class MeasurementScreen extends StatefulWidget {
  
  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wybierz parametry'),
        backgroundColor: const Color.fromRGBO(0, 80, 80, 1),

      ),
    );
  }
}