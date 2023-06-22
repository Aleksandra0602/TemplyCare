import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

import '../../utils/data_parser_method.dart';

class BatteryScreen extends StatefulWidget {
  BatteryScreen({Key? key, this.services}) : super(key: key);

  final List<BluetoothService>? services;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  double currentBatteryValue = 0;
  String batteryValue = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == Dimensions.service_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                Dimensions.charaCteristic_uuid) {
              characteristic.value.listen((value) {
                //print('AAAA' + dataParser(value));
                setState(() {
                  widget.readValues[characteristic.uuid] = value;
                });
                batteryValue = dataParser(value);
                currentBatteryValue = double.parse(batteryValue);
              });

              characteristic.read();
            }
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stan Baterii'),
        backgroundColor: MyColor.primary3,
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
                          disabledActiveTrackColor: Colors.lightGreen,
                          trackShape: const RectangularSliderTrackShape(),
                          trackHeight: 100,
                          thumbShape: SliderComponentShape.noThumb,
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 35,
                          ),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 250,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Slider(
                                value: currentBatteryValue,
                                max: 100,
                                min: 0,
                                divisions: 100,
                                onChanged: null,
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
                      style: const TextStyle(
                        fontSize: 28,
                        color: MyColor.backgroundColor,
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
