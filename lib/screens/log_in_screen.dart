import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';
import 'package:temp_app_v1/screens/sign_up_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/log_sign_field.dart';
import 'package:temp_app_v1/widgets/my_button.dart';
import 'package:temp_app_v1/widgets/password_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, this.services});
  final List<BluetoothService>? services;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _loginCheckController = TextEditingController();
  final _passwordCheckController = TextEditingController();

  String? validaton(String? value) {
    if (value == null || value.isEmpty) {
      return 'Musisz wypełnić to pole!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.log),
        backgroundColor: MyColor.appBarColor2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
            LogSignField('Login', Icons.person, _loginCheckController,
                validaton(_loginCheckController.text)),
            PasswordField(AppLocalizations.of(context)!.password,
                Icons.password, _passwordCheckController),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: (() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            CategoriesScreen(services: widget.services))));
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
      ),
    );
  }
}
