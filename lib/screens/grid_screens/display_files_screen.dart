import 'package:flutter/material.dart';

class DisplayFilesScreen extends StatelessWidget {
  const DisplayFilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Wyświetl dostępne pliki'),
        backgroundColor: const Color.fromRGBO(0, 110, 100, 1),
      ),
    );
  }
}
