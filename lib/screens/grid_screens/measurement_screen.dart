import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';

class MeasurementScreen extends StatefulWidget {
  final List<BluetoothService>? services;

  MeasurementScreen({Key? key, required this.services}) : super(key: key);

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final _measrementTimeController = TextEditingController(text: '5');
  final _sleepTimeController = TextEditingController(text: '10');
  final _tagController = TextEditingController();
  final _fileNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ustaw parametry'),
        backgroundColor: const Color.fromRGBO(0, 65, 55, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _measrementTimeController,
                decoration: const InputDecoration(
                  labelText: 'Czas pomiaru [min]',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(0, 65, 55, 0.8),
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 60, 50, 1),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _sleepTimeController,
                decoration: const InputDecoration(
                  labelText: 'Czas uśpienia [s]',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(0, 80, 80, 0.8),
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 60, 50, 1),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    labelText: 'Tag',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(0, 80, 80, 0.8),
                      fontSize: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 60, 50, 1),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _fileNameController,
                  decoration: const InputDecoration(
                    labelText: 'File name',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(0, 80, 80, 0.8),
                      fontSize: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 60, 50, 1),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 120,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.grey,
              onTap: () {
                if (_measrementTimeController.text != null) {
                  widget.services!.forEach((service) {
                    if (service.uuid.toString() == Dimensions.service_uuid) {
                      service.characteristics.forEach((characteristic) {
                        if (characteristic.uuid.toString() ==
                            Dimensions.charaCteristic_uuid) {
                          String var1 = _measrementTimeController.value.text;
                          String var2 = _sleepTimeController.value.text;
                          String warunek = '13,$var1,$var2';
                          characteristic.write(utf8.encode(warunek));
                          _showAlert(
                              context,
                              _measrementTimeController.value.text,
                              _sleepTimeController.value.text);
                        }
                      });
                    }
                  });
                } else {
                  _errorAlert(context);
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0, 65, 55, 0.8),
                ),
                height: 140,
                child: const Center(
                  child: Icon(
                    Icons.arrow_right,
                    size: 140,
                    color: Color.fromRGBO(235, 255, 235, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlert(BuildContext context, String var1, String var2) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Powiadomienie'),
            content: Text(
                'Pomiar się rozpoczyna z parametrami: \nCzas pomiaru: $var1 min\nCzas uśpienia: $var2 s'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color.fromRGBO(0, 50, 30, 1)),
                ),
              )
            ],
          );
        });
  }

  void _errorAlert(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Błąd'),
            content: const Text('Brak danych do pomiaru'),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'))
            ],
          );
        });
  }
}
