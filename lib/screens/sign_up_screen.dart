import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: const Text('Rejestracja'),
        backgroundColor: const Color.fromRGBO(0, 50, 50, 1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(),
    );
  }
}
