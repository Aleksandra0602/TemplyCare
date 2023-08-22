import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/textformfields/data_measurement_field.dart';

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
              color: Theme.of(context).backgroundColor,
              child: Get.isDarkMode
                  ? Image.asset('assets/szare_logo.png')
                  : Image.asset('assets/logo.png'),
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
                          decoration: BoxDecoration(
                            boxShadow: Get.isDarkMode
                                ? []
                                : [
                                    const BoxShadow(
                                      color: MyColor.shadow,
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                    ),
                                  ],
                            color: MyColor.primary2,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
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
                              Dimensions.measurement_service_uuid) {
                            service.characteristics.forEach((characteristic) {
                              if (characteristic.uuid.toString() ==
                                  Dimensions.data_to_measure_uuid) {
                                String timeM =
                                    _measrementTimeController.value.text;
                                String dtime = _sleepTimeController.value.text;
                                String tag = _tagController.value.text;
                                String fileName =
                                    _fileNameController.value.text;
                                String warunek =
                                    '13,$timeM,$dtime,$tag,$fileName';
                                characteristic.write(utf8.encode(warunek));
                                _showAlert(
                                  context,
                                  _measrementTimeController.value.text,
                                  _sleepTimeController.value.text,
                                  _tagController.value.text,
                                  _fileNameController.value.text,
                                );
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
                        boxShadow: Get.isDarkMode
                            ? []
                            : [
                                const BoxShadow(
                                  color: MyColor.shadow,
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                        color: Get.isDarkMode
                            ? Color.fromRGBO(160, 80, 20, 1)
                            : MyColor.additionalColor,
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

  void _showAlert(BuildContext context, String var1, String var2, String var3,
      String var4) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.alertDialog),
            content: Text(AppLocalizations.of(context)!
                .information
                .replaceFirst('{var1}', '$var1')
                .replaceFirst('{var2}', '$var2')
                .replaceFirst('{var3}', '$var3')
                .replaceFirst('{var4}', '$var4')),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // if (_measrementTimeController.text != null) {
                  //   widget.services!.forEach((service) {
                  //     if (service.uuid.toString() ==
                  //         Dimensions.measurement_service_uuid) {
                  //       service.characteristics.forEach((characteristic) {
                  //         if (characteristic.uuid.toString() ==
                  //             Dimensions.data_to_measure_uuid) {
                  //           characteristic.write(utf8.encode(""));
                  //           Navigator.of(context).pop();
                  //         }
                  //       });
                  //     }
                  //   });
                  // }
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.alertButton,
                  style: const TextStyle(
                    color: MyColor.additionalColor,
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
