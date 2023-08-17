import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temp_app_v1/models/login_response_model.dart';
import 'package:temp_app_v1/screens/log_in_screen.dart';
import 'package:temp_app_v1/utils/api_utils.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/log_sign_field.dart';
import 'package:temp_app_v1/widgets/my_button.dart';
import 'package:temp_app_v1/widgets/password_field.dart';

import '../models/user_controller.dart';
import 'grid_screens/categories_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.services}) : super(key: key);
  final List<BluetoothService>? services;

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
    }
  }

  void register() async {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    String login = _loginController.text;
    String email = _emailController.text;
    String password = _password1Controller.text;
    String password2 = _password2Controller.text;

    http.Response response;

    if (password.compareTo(password2) == 0) {
      response = await registerUser(login, email, password, null);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final dataUser = LoginResponseModel.fromJson(decodedResponse);

        _onLoginSuccess(dataUser);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => CategoriesScreen(services: widget.services)),
          ),
        );
      } else {
        print("Wystąpił błąd podczas rejestracji.");
        print("Kod statusu: ${response.statusCode}");
        print("Treść odpowiedzi: ${response.body}");
      }
    } else {
      print("Hasła są różne");
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
        title: Text(AppLocalizations.of(context)!.registration),
        backgroundColor: MyColor.appBarColor2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              child: Image.asset('assets/logo.png', fit: BoxFit.cover),
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
                register();

                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) =>
                //             CategoriesScreen(services: widget.services))));
              }),
              child: MyButton(
                color: MyColor.additionalColor,
                textButton: AppLocalizations.of(context)!.signIn,
                borderColor: MyColor.additionalColor,
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
                        builder: (context) => const LogInScreen()));
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
