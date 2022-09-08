import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';

class RealTemperatureScreen extends StatefulWidget {
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  RealTemperatureScreen({required this.services});

  final List<BluetoothService>? services;

  @override
  State<RealTemperatureScreen> createState() => _RealTemperatureScreenState();
}

class _RealTemperatureScreenState extends State<RealTemperatureScreen> {
  String service_uuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  String charaCteristic_uuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  String temperature = "";
  List<double> trace = [];
  late Stream<List<int>> stream;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  String _dataParser(List<int>? dataFromDevice) {
    if (dataFromDevice != null) {
      return utf8.decode(dataFromDevice);
    }
    return "null";
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == service_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() == charaCteristic_uuid) {
              // characteristic.setNotifyValue(!characteristic.isNotifying);
              // characteristic.value.listen((value) {
              //   setState(() {
              //     temperature = _dataParser(value);
              //   });
              // });
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
        title: Text('Aktualne pomiary'),
        backgroundColor: Color.fromRGBO(0, 100, 100, 1),
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
                child: const Text(
                  'Temperature 1',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
              ),
              Text(temperature),

              // Container(
              //   child: StreamBuilder<List<int>>(
              //       stream: widget.services?.last.characteristics.first.value,
              //       initialData: [],
              //       builder: (BuildContext context,
              //           AsyncSnapshot<List<int>> snapshot) {
              //         if (snapshot.connectionState == ConnectionState.active &&
              //             snapshot.hasData) {
              //           String currentVal = _dataParser(snapshot.data);
              //           //trace.add((double.parse(currentVal)));
              //           print(currentVal);
              //           return Row(
              //             children: <Widget>[
              //               Text(currentVal != null
              //                   ? 'Value : ${currentVal}'
              //                   : 'Brak danych')
              //             ],
              //           );
              //         } else {
              //           return Text('Check Stream');
              //         }
              //       }),
              // ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  'Temperature 2',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  'Humidity',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
