import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(
          strokeWidth: 6,
          color: MyColor.additionalColor,
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
