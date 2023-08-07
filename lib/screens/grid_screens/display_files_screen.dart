import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayFilesScreen extends StatelessWidget {
  const DisplayFilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.sixthAppBar),
        backgroundColor: MyColor.primary5,
      ),
    );
  }
}
