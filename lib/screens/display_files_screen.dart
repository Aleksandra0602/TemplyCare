import 'package:flutter/material.dart';


class DisplayFilesScreen extends StatelessWidget {
  const DisplayFilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wyświetl dostępne pliki'),
        backgroundColor: const Color.fromRGBO(0, 115, 115, 1),
      ),
    );
  }
}