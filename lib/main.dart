import 'package:flutter/material.dart';
import 'package:temp_app_v1/screens/first_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
      
      body: FirstScreen(),
      ),
    );
  }
}