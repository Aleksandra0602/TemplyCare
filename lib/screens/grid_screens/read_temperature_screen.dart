import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';

import '../../utils/data_parser_method.dart';
//import '../../widgets/line_chart_curve.dart';

class ReadTemperatureScreen extends StatefulWidget {
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  ReadTemperatureScreen({super.key, required this.services});

  final List<BluetoothService>? services;

  @override
  State<ReadTemperatureScreen> createState() => _ReadTemperatureScreenState();
}

class _ReadTemperatureScreenState extends State<ReadTemperatureScreen> {
  String warunek = '1,0,0';
  String temperature = "";
  // String temperature2 = "";
  String humidity = "";
  double temp1 = 5;
  List<double> trace = [];
  late Stream<List<int>> stream;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == Dimensions.service_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                Dimensions.charaCteristic_uuid) {
              characteristic.setNotifyValue(!characteristic.isNotifying);
              characteristic.value.listen((value) {
                List<double> list =
                    dataParser(value).split(',').map<double>((e) {
                  return double.parse(e);
                }).toList();
                setState(() {
                  // temperature = dataParser(value);
                  temperature = list[0].toString();
                  //temperature2 = list[1].toString();
                  humidity = list[1].toString();
                });
              });
              //TODO: przerobic na metode, ktora bedzie zwracac obiekt characteristic
              //ktory bedziemy wykorzystywac w StreamBuilderze jako strumien
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
      appBar: AppBar(
        title: const Text('Aktualne pomiary'),
        backgroundColor: const Color.fromRGBO(0, 100, 100, 1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Temperature 1:',
                  style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    color: Color.fromRGBO(4, 141, 111, 0.815),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Text(
                temperature,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin: const EdgeInsets.all(12), //nie używać
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Temperature 2:',
                  style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    color: Color.fromRGBO(4, 141, 111, 0.815),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              // Text(
              //   temperature2,
              //   style: const TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Humidity:',
                  style: TextStyle(
                    height: 2,
                    fontSize: 20,
                    color: Color.fromRGBO(4, 141, 111, 0.815),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Text(
                humidity,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
