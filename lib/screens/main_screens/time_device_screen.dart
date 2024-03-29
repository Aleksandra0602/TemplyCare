import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/utils/methods/data_parser_method.dart';

class TimeDeviceScreen extends StatefulWidget {
  final List<BluetoothService>? services;

  TimeDeviceScreen({Key? key, required this.services}) : super(key: key);
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  State<TimeDeviceScreen> createState() => _TimeDeviceScreenState();
}

class _TimeDeviceScreenState extends State<TimeDeviceScreen> {
  bool _isExpanded = false;

  var newDateUnix =
      DateTime.now().toUtc().millisecondsSinceEpoch + (2 * 60 * 60 * 1000);

  final newDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().toUtc().millisecondsSinceEpoch,
      isUtc: true);

  String timeOnDevice = "";
  String timeFromPhone = "";
  var timeV = 0.0;
  String format = "";
  String dataI = "";

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
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      realTimeClock();
    });
  }

  void loadData() {
    DateTime currentData = DateTime.now();
    format = DateFormat('HH:mm:ss,  dd-MM-yyyy').format(currentData);
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl', null);

    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? MyColor.darkBackgroundColor.withRed(60).withBlue(60).withGreen(60)
          : MyColor.primary6,
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
                    color: Theme.of(context).backgroundColor,
                    boxShadow: Get.isDarkMode
                        ? []
                        : [
                            const BoxShadow(
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
                              colors: Get.isDarkMode
                                  ? [
                                      MyColor.primary6,
                                      MyColor.primary7,
                                      MyColor.primary8,
                                    ]
                                  : [
                                      MyColor.appBarColor1,
                                      MyColor.appBarColor2,
                                      MyColor.appBarColor3,
                                    ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              DateFormat.EEEE(Get.locale?.languageCode ?? 'pl')
                                  .format(
                                DateTime.now(),
                              ),
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? MyColor.primary7
                                    : MyColor.appBarColor2,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(
                                DateTime.now(),
                              ),
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? MyColor.primary7
                                    : MyColor.appBarColor3,
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
                color: Theme.of(context).backgroundColor,
                boxShadow: Get.isDarkMode
                    ? []
                    : [
                        const BoxShadow(
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
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? MyColor.backgroundColor
                          : MyColor.appBarColor1,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });

                      if (_isExpanded) {
                        getDataFromArduino();
                        loadData();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? MyColor.darkAdditionalColor
                            : MyColor.additionalColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.download,
                        color: Theme.of(context).backgroundColor,
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
                  color: Theme.of(context).backgroundColor,
                  boxShadow: Get.isDarkMode
                      ? []
                      : [
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
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? MyColor.backgroundColor
                                  : MyColor.appBarColor1,
                            ),
                          ),
                          Text(format),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.deviceTime,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? MyColor.backgroundColor
                                  : MyColor.appBarColor1,
                            ),
                          ),
                          Text(formattedDateDevice),
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
                color: Theme.of(context).backgroundColor,
                boxShadow: Get.isDarkMode
                    ? []
                    : [
                        const BoxShadow(
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
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? MyColor.backgroundColor
                          : MyColor.appBarColor1,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      sendTimeToDevice();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? MyColor.darkAdditionalColor
                            : MyColor.additionalColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).backgroundColor,
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
            characteristic.write(utf8.encode(
                (DateTime.now().toUtc().millisecondsSinceEpoch +
                        (2 * 60 * 60 * 1000))
                    .toString()));
          }
        });
      }
    });
  }

  int unixData = 0;
  late DateTime dateDevice;
  late DateTime adjustedTime;
  String formattedDateDevice = '';

  void getDataFromArduino() {
    widget.services!.forEach((service) {
      if (service.uuid.toString() == Dimensions.time_service_uuid) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == Dimensions.timeDevice_uuid) {
            characteristic.value.listen((value) {
              setState(() {
                widget.readValues[characteristic.uuid] = value;
              });

              timeOnDevice = dataParser(value);

              timeV = double.tryParse(timeOnDevice)!;

              dataI = timeV.toStringAsFixed(0);

              unixData = int.parse(dataI);

              dateDevice =
                  DateTime.fromMicrosecondsSinceEpoch(unixData * 1000000);

              adjustedTime = dateDevice.subtract(const Duration(hours: 2));

              formattedDateDevice =
                  DateFormat('HH:mm:ss,  dd-MM-yyyy').format(adjustedTime);
            });
            characteristic.read();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
