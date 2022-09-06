import 'package:flutter/material.dart';


class BatteryScreen extends StatefulWidget {
  const BatteryScreen({Key? key}) : super(key: key);

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stan Baterii'),
        backgroundColor: const Color.fromRGBO(0, 100, 100, 1),
      ),
    );
  }
}