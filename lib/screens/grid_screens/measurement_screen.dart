import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.thirdAppBar),
        backgroundColor: MyColor.primary2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 160,
              color: MyColor.backgroundColor,
              child: Image.asset('assets/logo.png'),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 48, top: 16, right: 8, left: 8),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: MyColor.shadow,
                                spreadRadius: 2,
                                blurRadius: 8,
                              ),
                            ],
                            color: MyColor.primary2,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              DataMeasurementField(
                                textEditingController:
                                    _measrementTimeController,
                                text: AppLocalizations.of(context)!
                                    .measurementTime,
                                textType: TextInputType.number,
                              ),
                              DataMeasurementField(
                                textEditingController: _sleepTimeController,
                                text: AppLocalizations.of(context)!.sleepTime,
                                textType: TextInputType.number,
                              ),
                              DataMeasurementField(
                                textEditingController: _tagController,
                                text: AppLocalizations.of(context)!.tag,
                                textType: TextInputType.text,
                              ),
                              DataMeasurementField(
                                textEditingController: _fileNameController,
                                text: AppLocalizations.of(context)!.fileName,
                                textType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 380,
                  child: InkWell(
                    onTap: () {
                      if (_measrementTimeController.text != null) {
                        widget.services!.forEach((service) {
                          if (service.uuid.toString() ==
                              Dimensions.service_uuid) {
                            service.characteristics.forEach((characteristic) {
                              if (characteristic.uuid.toString() ==
                                  Dimensions.characteristic_uuid) {
                                String var1 =
                                    _measrementTimeController.value.text;
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
                      height: 72,
                      padding: const EdgeInsets.symmetric(horizontal: 96),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: MyColor.shadow,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        color: MyColor.additionalColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'START',
                          style: TextStyle(
                              color: MyColor.backgroundColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
            title: Text(AppLocalizations.of(context)!.alertDialog),
            content: Text(
                'Pomiar rozpoczyna się: \nCzas pomiaru: $var1 min\nCzas uśpienia: $var2 s\nTag:  xxx\nNazwa pliku: xxx.txt'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  AppLocalizations.of(context)!.alertButton,
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 50, 30, 1),
                    fontSize: 18,
                  ),
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
            title: Text(AppLocalizations.of(context)!.errorDialog),
            content: Text(AppLocalizations.of(context)!.errorMessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context)!.alertButton))
            ],
          );
        });
  }
}
