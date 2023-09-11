import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:temp_app_v1/models/login_response_model.dart';
import 'package:temp_app_v1/screens/log_sign_screens/sign_up_screen.dart';
import 'package:temp_app_v1/screens/main_screens/categories_screen.dart';
import 'package:temp_app_v1/utils/api/api_utils.dart';
import 'package:temp_app_v1/utils/constans/loading_widget.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_button.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_snack_bar.dart';

import 'package:temp_app_v1/widgets/textformfields/log_sign_field.dart';
import 'package:temp_app_v1/widgets/textformfields/password_field.dart';

import '../../models/user_controller.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, this.services, this.device});
  final List<BluetoothService>? services;
  final BluetoothDevice? device;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailCheckController = TextEditingController();
  final _passwordCheckController = TextEditingController();

  String? validaton(String? value) {
    if (value == null || value.isEmpty) {
      return 'Musisz wypełnić to pole!';
    } else {
      return "";
    }
  }

  void login(BuildContext context) async {
    String email = _emailCheckController.text;
    String password = _passwordCheckController.text;

    showLoadingWidget(context);

    http.Response response = await loginUser(email, password);
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final dataUser = LoginResponseModel.fromJson(decodedResponse);

      _onLoginSuccess(dataUser);
      if (!mounted) return;
      hideLoadingWidget(context);
      NavigatorState navigator = Navigator.of(context);

      navigator.pushReplacement(MaterialPageRoute(
          builder: ((context) => CategoriesScreen(
              services: widget.services, device: widget.device))));
    } else {
      if (!mounted) return;
      hideLoadingWidget(context);
      showBar(context, "Błąd logowania - nieprawidłowe dane");
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

    Get.off(() => CategoriesScreen(
          services: widget.services,
        ));
  }

  void showBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackBar(textSnackBar: text, context: context));
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
      // body: Login(
      //   services: widget.services,
      //   login: login,
      //   validaton: validaton(_emailCheckController.text),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              child: Get.isDarkMode
                  ? Image.asset('assets/szare_logo.png', fit: BoxFit.cover)
                  : Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                    ),
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
                login(context);
              }),
              child: MyButton(
                color: Get.isDarkMode
                    ? MyColor.darkAdditionalColor
                    : MyColor.additionalColor,
                textButton: AppLocalizations.of(context)!.logIn,
                borderColor: Get.isDarkMode
                    ? MyColor.darkAdditionalColor
                    : MyColor.additionalColor,
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
                        builder: (context) => SignUpScreen(
                            services: widget.services, device: widget.device)));
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
