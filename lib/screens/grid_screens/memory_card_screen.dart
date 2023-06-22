import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class MemoryCardScreen extends StatelessWidget {
  const MemoryCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Stan karty pamięci'),
        backgroundColor: MyColor.primary4,
      ),
    );
  }
}
