import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/my_button.dart';
import 'package:temp_app_v1/widgets/ripple_animate_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mój profil'),
        backgroundColor: MyColor.primary8,
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
                  MaterialPageRoute(
                      builder: (context) => RippleAnimateScreen()),
                );
              },
              child: const MyButton(
                color: MyColor.additionalColor,
                textButton: 'Wyloguj się',
                borderColor: MyColor.additionalColor,
                textColor: MyColor.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
