import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/screens/wifi_screen.dart';
import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temp_app_v1/utils/methods/data_parser_method.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_button.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_snack_bar.dart';

class DisplayFilesScreen extends StatefulWidget {
  DisplayFilesScreen({Key? key, this.services}) : super(key: key);
  final List<BluetoothService>? services;
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  State<DisplayFilesScreen> createState() => _DisplayFilesScreenState();
}

class _DisplayFilesScreenState extends State<DisplayFilesScreen> {
  List<String> fileNames = [];
  String textSnackBar = '';
  bool uploadCompleted = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget.services!.forEach((service) {
        if (service.uuid.toString() == Dimensions.SDCcontent_service_uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() ==
                Dimensions.SDCContent_read_uuid) {
              characteristic.value.listen((value) {
                String valueStr = String.fromCharCodes(value);
                List<String> files = valueStr.split('\n');
                setState(() {
                  fileNames = files;
                });
              });
              characteristic.read();
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.sixthAppBar),
        backgroundColor: MyColor.primary5,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 7,
            child: Scrollbar(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
                itemCount: fileNames.length,
                itemBuilder: (context, index) {
                  if (fileNames.isNotEmpty) {
                    return ListTile(
                      title: Text(fileNames[index]),
                    );
                  } else {
                    return const ListTile(
                      title: Text("No file names available"),
                    );
                  }
                },
              ),
            ),
          ),
          Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        fileNames
                                .where((fileName) => fileName.endsWith(".csv"))
                                .every(
                                    (fileName) => fileName.startsWith("SENT"))
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                MySnackBar(
                                    textSnackBar:
                                        "Wszystkie dane są już w bazie",
                                    context: context))
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WifiScreen(
                                    services: widget.services,
                                  );
                                });
                        getText();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: MyButton(
                          color: MyColor.additionalColor,
                          textButton: "Wyślij pliki",
                          borderColor: MyColor.additionalColor,
                          textColor: MyColor.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void getText() {
    widget.services!.forEach((service) {
      if (service.uuid.toString() == Dimensions.SDCcontent_service_uuid) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() ==
              Dimensions.SDCContent_send_order) {
            characteristic.value.listen((value) {
              String textStr = String.fromCharCodes(value);
              if (textStr == "Wysłano") {
                setState(() {
                  uploadCompleted = true;
                });
                _showSnackBar();
              }
            });
          }
        });
      }
    });
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
        MySnackBar(textSnackBar: "Dane zostały wysłane", context: context));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
