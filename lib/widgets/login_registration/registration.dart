import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:temp_app_v1/screens/log_sign_screens/log_in_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/bars_and_buttons/my_button.dart';
import 'package:temp_app_v1/widgets/textformfields/log_sign_field.dart';
import 'package:temp_app_v1/widgets/textformfields/password_field.dart';

class Registartion extends StatelessWidget {
  Registartion(
      {Key? key,
      this.validationLogin,
      this.validationMail,
      required this.register})
      : super(key: key);
  final _loginController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final String? validationLogin;
  final String? validationMail;
  final VoidCallback register;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 120,
            child: Image.asset('assets/logo.png', fit: BoxFit.cover),
          ),
          LogSignField(
            'Login',
            Icons.person,
            _loginController,
            validationLogin,
          ),
          LogSignField(
            'E-mail',
            Icons.mail,
            _emailController,
            validationMail,
          ),
          PasswordField(AppLocalizations.of(context)!.password, Icons.password,
              _password1Controller),
          PasswordField(AppLocalizations.of(context)!.repeatPassword,
              Icons.password, _password2Controller),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: (() {
              register;
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()));
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
    );
  }
}
