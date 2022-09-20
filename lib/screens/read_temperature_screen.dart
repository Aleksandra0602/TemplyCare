import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:temp_app_v1/utils/constans/dimensions.dart';

import '../utils/data_parser_method.dart';

class ReadTemperatureScreen extends StatefulWidget {
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  ReadTemperatureScreen({required this.services});

  final List<BluetoothService>? services;

  @override
  State<ReadTemperatureScreen> createState() => _ReadTemperatureScreenState();
}

class _ReadTemperatureScreenState extends State<ReadTemperatureScreen> {
  String temperature = "";
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
                setState(() {
                  temperature = dataParser(value);
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
              const Text('Tu będzie się wyświetlać temperatura i wilgotność'),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Temperature 1',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(temperature),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Temperature 2',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Humidity',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
