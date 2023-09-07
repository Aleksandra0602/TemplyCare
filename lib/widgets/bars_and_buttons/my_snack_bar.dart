import 'package:flutter/material.dart';

class MySnackBar extends SnackBar {
  MySnackBar({Key? key, required this.textSnackBar, required this.context})
      : super(
          key: key,
          content: Text(
            textSnackBar,
          ),
          duration: const Duration(milliseconds: 3000),
          width: MediaQuery.of(context).size.width - 20.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          behavior: SnackBarBehavior.floating,
        );

  final BuildContext context;
  final String textSnackBar;

  // @override
  // Widget build(BuildContext context) {
  //   return SnackBar(
  //     content: Text(textSnackBar),
  //     duration: const Duration(milliseconds: 3000),
  //     width: MediaQuery.of(context).size.width - 80.0,
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //   );
  // }
}
