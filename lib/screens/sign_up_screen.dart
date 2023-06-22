import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/screens/log_in_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/log_sign_field.dart';
import 'package:temp_app_v1/widgets/my_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Rejestracja'),
        backgroundColor: MyColor.appBarColor1,
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
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
            LogSignField('Login', Icons.person, _loginController),
            LogSignField('E-mail', Icons.mail, _emailController),
            LogSignField('Hasło', Icons.password, _password1Controller),
            LogSignField('Powtórz hasło', Icons.password, _password2Controller),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            CategoriesScreen(services: widget.services))));
              }),
              child: const MyButton(
                color: MyColor.additionalColor,
                textButton: 'Zarejestruj się',
                borderColor: MyColor.additionalColor,
                textColor: MyColor.backgroundColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Masz już konto?',
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LogInScreen()));
              },
              child: const Text(
                'Zaloguj się!',
                style: TextStyle(
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
