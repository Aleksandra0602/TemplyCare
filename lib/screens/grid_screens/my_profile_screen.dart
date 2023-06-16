import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Mój profil'),
        backgroundColor: const Color.fromRGBO(0, 155, 145, 1),
      ),
    );
  }
}
