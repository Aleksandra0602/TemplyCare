import 'package:flutter/material.dart';

import '../../utils/constans/my_color.dart';

class PasswordField extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextEditingController textEditingController;

  const PasswordField(this.text, this.icon, this.textEditingController,
      {Key? key})
      : super(key: key);

  @override
  State<PasswordField> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
            obscureText: _obscureText,
            controller: widget.textEditingController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                color: MyColor.primary1.withOpacity(0.5),
              ),
              suffixIcon: InkWell(
                onTap: _passwordVisibility,
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: MyColor.primary1.withOpacity(0.75),
                ),
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
