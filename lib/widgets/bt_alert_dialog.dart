import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../utils/constans/my_color.dart';

class BluetoothAlertDialog extends StatelessWidget {
  const BluetoothAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Bluetooth jest wyłączony!'),
      content: const Text(
          'Aby korzystać z aplikacji włącz Bluetooth na swoim urządzeniu'),
      actions: [
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: const Text(
            'Zamknij aplikację',
            style: TextStyle(color: MyColor.additionalColor),
          ),
        ),
        TextButton(
          onPressed: () {
            //AppSettings.openBluetoothSettings();

            turnOnBluetooth();
            //Navigator.pop(context);
          },
          child: const Text(
            'Włącz Bluetooth',
            style: TextStyle(color: MyColor.primary2),
          ),
        ),
      ],
    );
  }
}

Future<bool> turnOnBluetooth() async {
  return await FlutterBluePlus.instance.turnOn();
}
