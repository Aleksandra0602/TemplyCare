import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/screens/log_in_screen.dart';

import 'grid_screens/categories_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.services}) : super(key: key);
  final List<BluetoothService>? services;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // final _loginController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _password1Controller = TextEditingController();
  // final _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Rejestracja'),
        backgroundColor: const Color.fromRGBO(0, 25, 20, 0.8),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 140,
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color.fromRGBO(1, 60, 50, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 60, 50, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'E-mail:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Color.fromRGBO(1, 60, 50, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 60, 50, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Hasło:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Color.fromRGBO(1, 60, 50, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 60, 50, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Powtórz hasło:',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Color.fromRGBO(1, 60, 50, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 60, 50, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  child: const Center(
                    child: Text(
                      'Zarejestruj się',
                      style: TextStyle(
                        color: Color.fromRGBO(245, 255, 245, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
