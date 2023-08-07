import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:temp_app_v1/screens/log_in_screen.dart';
import 'package:temp_app_v1/screens/sign_up_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/my_button.dart';

class LogSignScreen extends StatefulWidget {
  const LogSignScreen({super.key, this.services});
  final List<BluetoothService>? services;

  @override
  State<LogSignScreen> createState() => _LogSignScreenState();
}

class _LogSignScreenState extends State<LogSignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColor.appBarColor2,
        title: const Text('TemplyCare'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: SizedBox(
                height: 280,
                child: Image.asset('assets/logo.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => LogInScreen(
                              services: widget.services,
                            ))));
              },
              child: MyButton(
                color: MyColor.primary2,
                textButton: AppLocalizations.of(context)!.logIn,
                borderColor: MyColor.primary2,
                textColor: MyColor.backgroundColor,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SignUpScreen())));
              },
              child: MyButton(
                color: MyColor.backgroundColor,
                textButton: AppLocalizations.of(context)!.signIn,
                borderColor: MyColor.primary2,
                textColor: MyColor.primary2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
