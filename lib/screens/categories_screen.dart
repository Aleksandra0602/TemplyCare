import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../models/button_data.dart';
import '../models/screens.dart';
import '../single_button.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    this.services,
  });

  final List<BluetoothService>? services;
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String temperature = "";
  List<double> trace = [];
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();
  List<int> value = [];

  String _dataParser(List<int>? dataFromDevice) {
    if (dataFromDevice != null) {
      return utf8.decode(dataFromDevice);
    }
    return "null";
  }

  @override
  void initState() {
    super.initState();
    print(widget.services);
  }

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
            .map((butData) => SingleButton(butData.id, butData.title,
                butData.color, widget.services, butData.screens))
            .toList(),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
