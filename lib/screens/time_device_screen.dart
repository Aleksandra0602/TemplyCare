import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TimeDeviceScreen extends StatefulWidget {
  const TimeDeviceScreen({Key? key}) : super(key: key);

  @override
  State<TimeDeviceScreen> createState() => _TimeDeviceScreenState();
}

class _TimeDeviceScreenState extends State<TimeDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Czas na urządzeniu pomiarowym', style: TextStyle(fontSize: 18),),
        backgroundColor: const Color.fromRGBO(0, 150, 150, 1),
      ),
    );
  }
}