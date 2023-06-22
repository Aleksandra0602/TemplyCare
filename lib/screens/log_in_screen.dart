import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';
import 'package:temp_app_v1/screens/sign_up_screen.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/log_sign_field.dart';
import 'package:temp_app_v1/widgets/my_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, this.services});
  final List<BluetoothService>? services;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _loginCheckController = TextEditingController();
  final _passwordCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Logowanie'),
        backgroundColor: MyColor.appBarColor1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
            const SizedBox(
              height: 10,
            ),
            LogSignField('Login', Icons.person, _loginCheckController),
            LogSignField('Hasło', Icons.password, _passwordCheckController),
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
              child: const MyButton(
                color: MyColor.additionalColor,
                textButton: 'Zaloguj się',
                borderColor: MyColor.additionalColor,
                textColor: MyColor.backgroundColor,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Nie masz jeszcze konta?',
              style: TextStyle(
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
              child: const Text(
                'Zarejestruj się!',
                style: TextStyle(
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
