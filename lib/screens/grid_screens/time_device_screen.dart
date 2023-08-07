import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/data_parser_method.dart';

class TimeDeviceScreen extends StatefulWidget {
  List<BluetoothService>? services;

  TimeDeviceScreen({required this.services});
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  State<TimeDeviceScreen> createState() => _TimeDeviceScreenState();
}

class _TimeDeviceScreenState extends State<TimeDeviceScreen> {
  bool _isExpanded = false;

  var newDateUnix = DateTime.now().toUtc().millisecondsSinceEpoch;

  final newDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().toUtc().millisecondsSinceEpoch,
      isUtc: true);

  String timeOnDevice = "";
  String timeFromPhone = "";

  final StreamController _streamController = StreamController();

  Future<void> realTimeClock() async {
    var current = DateTime.now().toString().split(' ');
    var date = List.from(current[0].split('-').reversed).join('.');
    var time = current[1];
    var data = {
      'date': date,
      'time': time,
    };
    if (!_streamController.isClosed) _streamController.sink.add(data);
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      realTimeClock();
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl', null);

    return Scaffold(
      backgroundColor: MyColor.primary6,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.timeDevice,
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: MyColor.primary6,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: MyColor.backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 4,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: StreamBuilder(
                    stream: _streamController.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return Column(
                          children: [
                            GradientText(
                              '${data['time'].substring(0, data['time'].indexOf('.'))}',
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                              ),
                              colors: const [
                                MyColor.appBarColor1,
                                MyColor.appBarColor2,
                                MyColor.appBarColor3,
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              DateFormat.EEEE('pl').format(
                                DateTime.now(),
                              ),
                              style: const TextStyle(
                                color: MyColor.appBarColor2,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(
                                DateTime.now(),
                              ),
                              style: const TextStyle(
                                color: MyColor.appBarColor3,
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Text('error');
                      } else {
                        return Text(AppLocalizations.of(context)!.timeError);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyColor.backgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.checkDate,
                    style: const TextStyle(
                      color: MyColor.appBarColor1,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    // onTap: () {
                    //   widget.services!.forEach((service) {
                    //     if (service.uuid.toString() ==
                    //         Dimensions.time_service_uuid) {
                    //       service.characteristics.forEach((characteristic) {
                    //         if (characteristic.uuid.toString() ==
                    //             Dimensions.timeDevice_uuid) {
                    //           characteristic.value.listen((value) {
                    //             setState(() {
                    //               _isExpanded = !_isExpanded;

                    //               widget.readValues[characteristic.uuid] =
                    //                   value;
                    //             });
                    //             timeOnDevice = dataParser(value);
                    //           });
                    //           characteristic.read();
                    //         }
                    //       });
                    //     }
                    //   });
                    // },
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: MyColor.additionalColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.download,
                        color: MyColor.backgroundColor,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              height: _isExpanded ? 80 : 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColor.backgroundColor,
                  boxShadow: [
                    _isExpanded
                        ? const BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 2,
                            color: Colors.grey,
                          )
                        : const BoxShadow(blurRadius: 0, spreadRadius: 0),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.askTime,
                            style: const TextStyle(
                              color: MyColor.appBarColor1,
                            ),
                          ),
                          Text('aaaaaaaaa'),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.deviceTime,
                            style: const TextStyle(
                              color: MyColor.appBarColor1,
                            ),
                          ),
                          Text('aaaaaaaaaa'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyColor.backgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sendTime,
                    style: const TextStyle(
                      color: MyColor.appBarColor1,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      sendTimeToDevice();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: MyColor.additionalColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: MyColor.backgroundColor,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendTimeToDevice() {
    widget.services!.forEach((service) {
      if (service.uuid.toString() == Dimensions.time_service_uuid) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == Dimensions.timePhone_uuid) {
            characteristic.write(utf8.encode(newDateUnix.toString()));
          }
        });
      }
    });
  }
}
