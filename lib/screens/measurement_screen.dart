import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:temp_app_v1/utils/constans/dimensions.dart';

class MeasurementScreen extends StatefulWidget {
  final List<BluetoothService>? services;

  MeasurementScreen({required this.services});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  //String dropDownValue1 = measurementTime.first;
  //String dropDownValue2 = sleepTime.first;

  final _measrementTimeController = TextEditingController(text: '5');
  final _sleepTimeController = TextEditingController(text: '10');
  final _tagController = TextEditingController();
  final _fileNameController = TextEditingController();
  String warunek = '13,5,3';

  // static const List<String> measurementTime = <String>[
  //   '5',
  //   '10',
  //   '15',
  // ];

  // static const List<String> sleepTime = <String>[
  //   '3',
  //   '5',
  //   '10',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wybierz parametry'),
        backgroundColor: const Color.fromRGBO(0, 80, 80, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _measrementTimeController,
                decoration: const InputDecoration(
                    labelText: 'Czas pomiaru [min]',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(0, 80, 80, 0.8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              // child: DropdownButtonFormField<String>(
              //     value: dropDownValue1,
              //     icon: const Icon(Icons.arrow_downward_outlined),
              //     elevation: 16,
              //     items: measurementTime
              //         .map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //     decoration: InputDecoration(
              //       labelText: 'Czas pomiaru [min]',
              //       labelStyle:
              //           const TextStyle(color: Color.fromRGBO(0, 80, 80, 1)),
              //       border: OutlineInputBorder(),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: Color.fromRGBO(0, 20, 20, 1)),
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     onChanged: (String? value) {
              //       setState(() {
              //         dropDownValue1 = value!;
              //       });
              //     }),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _sleepTimeController,
                decoration: const InputDecoration(
                    labelText: 'Czas uśpienia [s]',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(0, 80, 80, 0.8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              // child: DropdownButtonFormField<String>(
              //     value: dropDownValue2,
              //     icon: Icon(Icons.arrow_downward_outlined),
              //     elevation: 16,
              //     items:
              //         sleepTime.map<DropdownMenuItem<String>>((String value2) {
              //       return DropdownMenuItem<String>(
              //         value: value2,
              //         child: Text(value2),
              //       );
              //     }).toList(),
              //     decoration: const InputDecoration(
              //       labelText: 'Czas uśpienia [s]',
              //       labelStyle: TextStyle(color: Color.fromRGBO(0, 80, 80, 1)),
              //       border: OutlineInputBorder(),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: Color.fromRGBO(0, 20, 20, 1)),
              //       ),
              //     ),
              //     onChanged: (String? value2) {
              //       setState(() {
              //         dropDownValue2 = value2!;
              //       });
              //     }),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    labelText: 'Tag',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(0, 80, 80, 0.8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _fileNameController,
                  decoration: const InputDecoration(
                    labelText: 'File name',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(0, 80, 80, 0.8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
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
                          String warunek2 = '13,$var1,$var2';
                          characteristic.write(utf8.encode(warunek2));
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
                width: 200,
                height: 50,
                color: const Color.fromRGBO(0, 40, 40, 1),
                child: const Center(
                    child: Text(
                  'Uruchom pomiar',
                  style: TextStyle(color: Colors.white),
                )),
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
                  child: const Text('OK'))
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
            content: Text('Brak danych do pomiaru'),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'))
            ],
          );
        });
  }
}
