import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/constans/my_color.dart';

class DataMeasurementField extends StatefulWidget {
  const DataMeasurementField(
      {super.key,
      required this.textEditingController,
      required this.text,
      required this.textType});

  final TextEditingController textEditingController;
  final String text;
  final TextInputType textType;

  @override
  State<DataMeasurementField> createState() => _DataMeasurementFieldState();
}

class _DataMeasurementFieldState extends State<DataMeasurementField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: widget.textType,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          labelText: widget.text,
          labelStyle: const TextStyle(
            color: MyColor.primary2,
            fontSize: 18,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColor.primary2,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.primary6, width: 2),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
