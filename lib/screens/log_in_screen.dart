import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_v1/models/login_response_model.dart';

import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';
import 'package:temp_app_v1/screens/sign_up_screen.dart';
import 'package:temp_app_v1/utils/api_utils.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/log_sign_field.dart';
import 'package:temp_app_v1/widgets/my_button.dart';
import 'package:temp_app_v1/widgets/password_field.dart';

import '../models/user_controller.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, this.services});
  final List<BluetoothService>? services;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailCheckController = TextEditingController();
  final _passwordCheckController = TextEditingController();

  String? validaton(String? value) {
    if (value == null || value.isEmpty) {
      return 'Musisz wypełnić to pole!';
    }
  }

  void login() async {
    String email = _emailCheckController.text;
    String password = _passwordCheckController.text;

    // await loginUser(email, password).then((value) {
    //   _onLoginSuccess(value, userController);
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: ((context) => CategoriesScreen(services: widget.services)),
    //     ),
    //   );
    // });

    http.Response response = await loginUser(email, password);
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final dataUser = LoginResponseModel.fromJson(decodedResponse);

      _onLoginSuccess(dataUser);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  CategoriesScreen(services: widget.services))));
    } else {
      print("Wystąpił błąd podczas logowania.");
      print("Kod statusu: ${response.statusCode}");
      print("Treść odpowiedzi: ${response.body}");
    }
  }

  void _onLoginSuccess(
    LoginResponseModel responseData,
  ) {
    final userController = Get.put(UserController());
    userController.setUser(
      responseData.id,
      responseData.login,
      responseData.email,
      responseData.image,
    );

    Get.off(CategoriesScreen(
      services: widget.services,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
            LogSignField('E-mail', Icons.mail, _emailCheckController,
                validaton(_emailCheckController.text)),
            PasswordField(AppLocalizations.of(context)!.password,
                Icons.password, _passwordCheckController),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: (() {
                login();
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
