import 'package:flutter/material.dart';

import '../../utils/constans/my_color.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 14,
              color: MyColor.backgroundColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            keyboardType: widget.textType,
            controller: widget.textEditingController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              filled: true,
              fillColor: Theme.of(context).backgroundColor,
              focusColor: MyColor.additionalColor,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: MyColor.backgroundColor.withOpacity(0.5),
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: MyColor.additionalColor, width: 2),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
