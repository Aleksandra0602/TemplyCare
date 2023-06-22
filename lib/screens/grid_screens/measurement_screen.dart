import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/data_measurement_field.dart';

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
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ustaw parametry'),
        backgroundColor: MyColor.primary2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            DataMeasurementField(
              textEditingController: _measrementTimeController,
              text: 'Czas pomiaru [min]',
              textType: TextInputType.number,
            ),
            DataMeasurementField(
              textEditingController: _sleepTimeController,
              text: 'Czas uśpienia [s]',
              textType: TextInputType.number,
            ),
            DataMeasurementField(
              textEditingController: _tagController,
              text: 'Tag',
              textType: TextInputType.text,
            ),
            DataMeasurementField(
              textEditingController: _fileNameController,
              text: 'Nazwa pliku',
              textType: TextInputType.text,
            ),
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
