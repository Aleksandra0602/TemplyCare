import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/screens/log_in_screen.dart';
import 'package:temp_app_v1/screens/sign_up_screen.dart';

class LogSignScreen extends StatefulWidget {
  const LogSignScreen({super.key, this.services});
  final List<BluetoothService>? services;

  @override
  State<LogSignScreen> createState() => _LogSignScreenState();
}

class _LogSignScreenState extends State<LogSignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 25, 20, 0.8),
        title: const Text('TemplyCare'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 280,
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => LogInScreen(
                            services: widget.services,
                          )))); //zmienic
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(1, 60, 40, 1),
                ),
                child: const Center(
                  child: Text(
                    'Zaloguj się',
                    style: TextStyle(
                      color: Color.fromRGBO(245, 255, 245, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => SignUpScreen()))); //zmienic
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 3, color: Color.fromRGBO(0, 100, 100, 1))),
                child: const Center(
                  child: Text(
                    'Zarejestruj się',
                    style: TextStyle(
                      color: Color.fromRGBO(1, 60, 50, 0.8),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
