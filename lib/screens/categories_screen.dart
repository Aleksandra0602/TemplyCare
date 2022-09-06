import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../models/button_data.dart';
import '../single_button.dart';

class CategoriesScreen extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          children: BUTTON_DATA
              .map((butData) => SingleButton(butData.id, butData.title, butData.color))
              .toList(),
          padding: EdgeInsets.all(10),
        ),
    );
  }
}
