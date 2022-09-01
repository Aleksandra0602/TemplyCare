import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'MyTemperature',
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            
          ),
          button: TextStyle(
            color: Colors.white
          ),
        ),
        appBarTheme: AppBarTheme(titleTextStyle: TextStyle(fontSize: 25)),
        backgroundColor: Color.fromRGBO(0, 80, 80, 1),
      ),
      home: CategoriesScreen(),
    );
  }
}