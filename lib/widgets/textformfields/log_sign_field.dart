import 'package:flutter/material.dart';

import '../../utils/constans/my_color.dart';

class LogSignField extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextEditingController textEditingController;
  final String? validation;

  LogSignField(
      this.text, this.icon, this.textEditingController, this.validation);

  @override
  State<LogSignField> createState() => LogSignFieldState();
}

class LogSignFieldState extends State<LogSignField> {
  final _formkey = GlobalKey<FormState>();
  String text2 = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
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
              validator: (value) => widget.validation,
              controller: widget.textEditingController,
              onChanged: (value) => setState(() {
                text2 = value;
              }),
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
      ),
    );
  }
}
