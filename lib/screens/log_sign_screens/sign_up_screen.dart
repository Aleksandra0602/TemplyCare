import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_v1/models/login_response_model.dart';
import 'package:temp_app_v1/screens/log_sign_screens/log_in_screen.dart';
import 'package:temp_app_v1/utils/api/api_utils.dart';
import 'package:temp_app_v1/utils/constans/loading_widget.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_snack_bar.dart';

import 'package:temp_app_v1/widgets/textformfields/log_sign_field.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_button.dart';
import 'package:temp_app_v1/widgets/textformfields/password_field.dart';

import '../../models/user_controller.dart';
import '../main_screens/categories_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.services, this.device}) : super(key: key);
  final List<BluetoothService>? services;
  final BluetoothDevice? device;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _loginController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  String? validationLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Musisz wypełnić to pole!';
    } else {
      return "";
    }
  }

  String? validationMail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Musisz wypełnić to pole!';
    }
    if (!value.contains('@')) {
      return 'Adres e-mail musi zawierać @';
    }
    if (value.endsWith('.') || value.endsWith(',')) {
      return 'Adres e-mail nie może kończyć się tym znakiem!';
    } else {
      return "";
    }
  }

  void register(BuildContext context) async {
    String login = _loginController.text;
    String email = _emailController.text;
    String password = _password1Controller.text;
    String password2 = _password2Controller.text;

    if (password.compareTo(password2) == 0) {
      showLoadingWidget(context);
      http.Response response = await registerUser(login, email, password, null);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final dataUser = LoginResponseModel.fromJson(decodedResponse);

        _onLoginSuccess(dataUser);

        if (!mounted) return;

        hideLoadingWidget(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => CategoriesScreen(services: widget.services)),
          ),
        );
      } else {
        if (!mounted) return;
        hideLoadingWidget(context);
        showBar(context, "Wystąpił błąd podczas rejestracji.");
      }
    } else {
      showBar(context, "Hasła są różne");
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
        title: Text(AppLocalizations.of(context)!.registration),
        backgroundColor: MyColor.appBarColor2,
        centerTitle: true,
      ),
      //body: Registartion(register: register,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 120,
              child: Get.isDarkMode
                  ? Image.asset(
                      'assets/szare_logo.png',
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
            LogSignField(
              'Login',
              Icons.person,
              _loginController,
              validationLogin(_loginController.text),
            ),
            LogSignField(
              'E-mail',
              Icons.mail,
              _emailController,
              validationMail(_emailController.text),
            ),
            PasswordField(AppLocalizations.of(context)!.password,
                Icons.password, _password1Controller),
            PasswordField(AppLocalizations.of(context)!.repeatPassword,
                Icons.password, _password2Controller),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (() {
                register(context);
              }),
              child: MyButton(
                color: Get.isDarkMode
                    ? const Color.fromRGBO(160, 80, 20, 1)
                    : MyColor.additionalColor,
                textButton: AppLocalizations.of(context)!.signIn,
                borderColor: Get.isDarkMode
                    ? const Color.fromRGBO(160, 80, 20, 1)
                    : MyColor.additionalColor,
                textColor: MyColor.backgroundColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.accountMessage,
              style: const TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(
                      services: widget.services,
                      device: widget.device,
                    ),
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.logIn,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: MyColor.appBarColor2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
