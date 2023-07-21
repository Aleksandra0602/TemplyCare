import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/utils/constans/dimensions.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:temp_app_v1/widgets/main_drawer.dart';

import '../../widgets/button_data.dart';
import '../../widgets/single_button.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        title: const Text('TemplyCare'),
        backgroundColor: MyColor.appBarColor2,
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Dimensions.HEIGHT,
          childAspectRatio: 1,
          crossAxisSpacing: Dimensions.SPACE,
          mainAxisSpacing: Dimensions.SPACE,
        ),
        padding: const EdgeInsets.all(10),
        children: BUTTON_DATA
            .map((butData) => SingleButton(
                butData.title, butData.color, widget.services, butData.screens))
            .toList(),
      ),
    );
  }
}
