import 'package:flutter/material.dart';

class MemoryCardScreen extends StatelessWidget {
  const MemoryCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 255, 245, 1),
      appBar: AppBar(
        title: const Text('Stan karty pamięci'),
        backgroundColor: const Color.fromRGBO(0, 95, 85, 1),
      ),
    );
  }
}
