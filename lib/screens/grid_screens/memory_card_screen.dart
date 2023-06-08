import 'package:flutter/material.dart';

class MemoryCardScreen extends StatelessWidget {
  const MemoryCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stan karty pamięci'
        ),
        backgroundColor: const Color.fromRGBO(0, 115, 115, 1),
      ),
    );
  }
}