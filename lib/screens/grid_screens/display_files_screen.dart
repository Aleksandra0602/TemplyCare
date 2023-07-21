import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class DisplayFilesScreen extends StatelessWidget {
  const DisplayFilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wyświetl dostępne pliki'),
        backgroundColor: MyColor.primary5,
      ),
    );
  }
}
