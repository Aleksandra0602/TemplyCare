import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';
import 'package:temp_app_v1/screens/sign_up_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key, this.services});
  final List<BluetoothService>? services;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _loginCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Logowanie'),
        backgroundColor: const Color.fromRGBO(0, 25, 20, 0.8),
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
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: _loginCheckController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromRGBO(1, 60, 50, 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasło:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _loginCheckController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: Color.fromRGBO(1, 60, 50, 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
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
                      'Zaloguj się',
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
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
