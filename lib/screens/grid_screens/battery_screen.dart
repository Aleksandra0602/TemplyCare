import 'package:flutter/material.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({Key? key}) : super(key: key);

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  double currentBatteryValue = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Stan Baterii'),
        backgroundColor: const Color.fromRGBO(0, 80, 70, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 350,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 80, 70, 0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.green,
                          inactiveTrackColor: Colors.grey.shade500,
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 100,
                          thumbShape: SliderComponentShape.noThumb,
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 35,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 250,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Slider(
                                value: currentBatteryValue,
                                max: 100,
                                min: 0,
                                divisions: 100,
                                onChanged: (double value) {
                                  setState(() {
                                    currentBatteryValue = value;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.flash_on,
                          size: 50,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      currentBatteryValue.toStringAsFixed(0) + '%',
                      style: TextStyle(
                        fontSize: 48,
                        color: const Color.fromRGBO(245, 255, 245, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: const [
                  Text(
                    'Baterii wystarczy na:',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '8 h 32 min',
                    style: TextStyle(
                        fontSize: 48, color: Color.fromRGBO(0, 70, 60, 1)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Dane o wykorzystaniu baterii są przybliżone i mogą się zmienić w zależności od sposobu używania urządzenia',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
