import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:temp_app_v1/screens/log_sign_screens/sign_up_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_button.dart';
import 'package:temp_app_v1/widgets/textformfields/log_sign_field.dart';
import 'package:temp_app_v1/widgets/textformfields/password_field.dart';

class Login extends StatelessWidget {
  Login({Key? key, required this.services, required this.login, this.validaton})
      : super(key: key);
  final _emailCheckController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final List<BluetoothService>? services;
  final VoidCallback login;
  final String? validaton;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 200,
            child: Image.asset('assets/logo.png', fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          LogSignField('E-mail', Icons.mail, _emailCheckController, validaton),
          PasswordField(AppLocalizations.of(context)!.password, Icons.password,
              _passwordCheckController),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: (() {
              login;
            }),
            child: MyButton(
              color: MyColor.additionalColor,
              textButton: AppLocalizations.of(context)!.logIn,
              borderColor: MyColor.additionalColor,
              textColor: MyColor.backgroundColor,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            AppLocalizations.of(context)!.logMessage,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
            },
            child: Text(
              AppLocalizations.of(context)!.signIn,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromRGBO(1, 60, 50, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
