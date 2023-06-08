import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/screens/grid_screens/categories_screen.dart';

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
      appBar: AppBar(
        title: const Text('Logowanie'),
        backgroundColor: const Color.fromRGBO(0, 50, 50, 1),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _loginCheckController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Login*',
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(200, 110, 5, 1)),
                  //labelStyle: TextStyle(color: Color.fromRGBO(200, 110, 5, 1)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(200, 110, 5, 1)))),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              controller: _loginCheckController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.password_outlined),
                  labelText: 'Hasło*',
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(200, 110, 5, 1)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(200, 110, 5, 1)))),
            ),
          ),
          InkWell(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          CategoriesScreen(services: widget.services))));
            }),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(200, 110, 5, 0.7),
                ),
                child: const Center(
                  child: Text(
                    'Zaloguj się',
                    style: TextStyle(
                      color: Color.fromARGB(220, 255, 255, 255),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
