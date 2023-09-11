import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 120,
        width: 120,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            strokeWidth: 8,
            color: MyColor.additionalColor,
          ),
        ),
      ),
    );
  }
}

void showLoadingWidget(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const LoadingWidget();
    },
  );
}

void hideLoadingWidget(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop(); // Close the loading dialog
}
