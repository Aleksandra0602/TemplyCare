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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black)
            ),
          ),
          Row(
            children: <Widget>[
              Text('Stan baterii wynosi: '),
              Text('tu bedzie jakas wartość w V'),
            ],
            
          ),
          Row(
            children: <Widget>[
              Text('Stan baterii'),
              Text('Tu będzie jakoś obliczone na %'),
            ],
          ),
          Text('Baterii w urządzeniu wystarczy na XXX czasu'),
        ],
      ),
    );
  }
}