import 'package:flutter/material.dart';
import 'package:temp_app_v1/screens/log_sign_screen.dart';
import 'package:temp_app_v1/widgets/ripple_animate.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Mój profil'),
        backgroundColor: const Color.fromRGBO(0, 155, 145, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 280,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 155, 145, 0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(4, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey.shade200,
                    size: 150,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informacje o użytkowniku',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text('Tu będą jakieś informacje o użytkowniku'),
                ],
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RippleAnimate()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  child: const Center(
                    child: Text(
                      'Wyloguj się',
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
          ],
        ),
      ),
    );
  }
}
