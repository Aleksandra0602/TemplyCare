import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:temp_app_v1/screens/log_sign_screens/log_sign_screen.dart';
import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_button.dart';

import '../utils/constans/my_color.dart';

class WifiScreen extends StatefulWidget {
  WifiScreen({Key? key, this.services}) : super(key: key);
  final List<BluetoothService>? services;

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  bool _obscureText = true;
  final _wifiSSIDController = TextEditingController();
  final _wifiPasswordController = TextEditingController();

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Dane Wi-Fi"),
      content: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Text(
                AppLocalizations.of(context)!.wifiSSID,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _wifiSSIDController,
                decoration: const InputDecoration(
                  hintText: "np. TP-Link2418",
                  hintStyle: TextStyle(fontSize: 14),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: MyColor.additionalColor, width: 3),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                AppLocalizations.of(context)!.wifiPassword,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _wifiPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: _passwordVisibility,
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: MyColor.additionalColor,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: MyColor.additionalColor, width: 3),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                AppLocalizations.of(context)!.wifiText,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              sendWifiData(_wifiSSIDController, _wifiPasswordController),
          child: Text(
            AppLocalizations.of(context)!.writeWifiData,
            style: TextStyle(color: MyColor.additionalColor),
          ),
        ),
      ],
    );
  }

  void sendWifiData(TextEditingController _wifiSSIDController,
      TextEditingController _wifiPasswordController) {
    widget.services!.forEach((service) {
      if (service.uuid.toString() == Dimensions.const_var_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == Dimensions.wifi_char_uuid) {
            String ssidWifi = _wifiSSIDController.value.text;
            String passwordWifi = _wifiPasswordController.value.text;
            String wifiData = '$ssidWifi,$passwordWifi';
            characteristic.write(utf8.encode(wifiData));
          }
        });
      }
    });
    Navigator.pop(context);
  }
}
