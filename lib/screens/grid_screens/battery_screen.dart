import 'package:flutter/material.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({Key? key}) : super(key: key);

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  String firstText = 'Stan baterii wynosi: ';
  String secondText = 'tu bedzie jakas wartość w V';
  String thirdText = 'Tu będzie jakoś obliczone na %';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Stan Baterii'),
        backgroundColor: const Color.fromRGBO(0, 80, 70, 1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 250,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black)),
          ),
          Text(
            '$firstText $secondText',
          ),
          Text(
            '$firstText $thirdText',
          ),
          const Text('Baterii w urządzeniu wystarczy na XXX czasu'),
        ],
      ),
    );
  }
}
