import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/data_parser_method.dart';

class TimeDeviceScreen extends StatefulWidget {
  List<BluetoothService>? services;

  TimeDeviceScreen({required this.services});
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  State<TimeDeviceScreen> createState() => _TimeDeviceScreenState();
}

class _TimeDeviceScreenState extends State<TimeDeviceScreen> {
  var newDateUnix = DateTime.now().toUtc().millisecondsSinceEpoch;

  final newDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().toUtc().millisecondsSinceEpoch,
      isUtc: true);

  String wartosc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Czas na urządzeniu pomiarowym',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color.fromRGBO(0, 150, 150, 1),
      ),
      body: Column(
        children: <Widget>[
          OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Pobierz datę',
                style: TextStyle(color: Color.fromRGBO(0, 100, 100, 1)),
              )),
          Text(newDateUnix.toString()),
          TextButton(
            onPressed: () {
              widget.services!.forEach((service) {
                if (service.uuid.toString() == Dimensions.service_uuid) {
                  service.characteristics.forEach((characteristic) {
                    if (characteristic.uuid.toString() ==
                        Dimensions.charaCteristic_uuid) {
                      characteristic.write(utf8.encode(newDateUnix.toString()));
                    }
                  });
                }
              });
            },
            child: const Text("Prześlij"),
          ),
          TextButton(
            child: const Text('Pobierz z ESP'),
            onPressed: () async {
              widget.services!.forEach((service) {
                if (service.uuid.toString() == Dimensions.service_uuid) {
                  service.characteristics.forEach((characteristic) {
                    if (characteristic.uuid.toString() ==
                        Dimensions.charaCteristic_uuid) {
                      characteristic.value.listen((value) {
                        setState(() {
                          widget.readValues[characteristic.uuid] = value;
                        });
                        wartosc = dataParser(value);
                      });
                      characteristic.read();
                      print(wartosc);
                    }
                  });
                }
              });
            },
          ),
          Text(wartosc),
        ],
      ),
    );
  }
}
