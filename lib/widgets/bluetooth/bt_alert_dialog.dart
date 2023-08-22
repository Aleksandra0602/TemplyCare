import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/constans/my_color.dart';

class BluetoothAlertDialog extends StatelessWidget {
  const BluetoothAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.bleTitle),
      content: Text(AppLocalizations.of(context)!.bleMessage),
      actions: [
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text(
            AppLocalizations.of(context)!.bleClose,
            style: const TextStyle(color: MyColor.additionalColor),
          ),
        ),
        TextButton(
          onPressed: () {
            //AppSettings.openBluetoothSettings();

            turnOnBluetooth();
            //Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)!.bleOn,
            style: const TextStyle(color: MyColor.primary2),
          ),
        ),
      ],
    );
  }
}

Future<bool> turnOnBluetooth() async {
  return await FlutterBluePlus.instance.turnOn();
}
