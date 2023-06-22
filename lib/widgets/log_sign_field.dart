import 'package:flutter/material.dart';

import '../utils/constans/my_color.dart';

class LogSignField extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextEditingController textEditingController;

  LogSignField(this.text, this.icon, this.textEditingController);

  @override
  State<LogSignField> createState() => LogSignFieldState();
}

class LogSignFieldState extends State<LogSignField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                color: const Color.fromRGBO(1, 60, 50, 0.5),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: MyColor.additionalColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
