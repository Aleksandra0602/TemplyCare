import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _enabled = false;
  bool _isExpanded = false;
  bool _isExpanded2 = false;
  late int selectedRadio = 1;
  bool currState = true;

  void toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void tempUnitExpanded() {
    setState(() {
      _isExpanded2 = !_isExpanded2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.bottomBar4),
        backgroundColor: MyColor.primary7,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.language,
                color: MyColor.primary7,
                size: 32,
              ),
              title: Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: InkWell(
                onTap: toggleExpanded,
                child: const Icon(
                  Icons.arrow_downward,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              height: _isExpanded ? 130 : 0,
              child: ListView(
                children: [
                  ListTile(
                    leading: Image.asset('assets/pl20.png'),
                    title: Text(
                      AppLocalizations.of(context)!.polish,
                    ),
                    trailing: Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      onChanged: (val) {
                        setSelectedRadio(val as int);
                      },
                      activeColor: MyColor.additionalColor,
                    ),
                  ),
                  //Divider(),
                  ListTile(
                    leading: Image.asset('assets/GB20.png'),
                    title: Text(
                      AppLocalizations.of(context)!.english,
                    ),
                    trailing: Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      onChanged: (val) {
                        setSelectedRadio(val as int);
                      },
                      activeColor: MyColor.additionalColor,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              enabled: _enabled,
              leading: const Icon(
                Icons.bedtime,
                color: MyColor.primary7,
                size: 32,
              ),
              title: Text(
                AppLocalizations.of(context)!.darkMode,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                _enabled
                    ? AppLocalizations.of(context)!.darkTurnOn
                    : AppLocalizations.of(context)!.darkTurnOff,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Switch(
                activeColor: MyColor.additionalColor,
                value: _enabled,
                onChanged: (bool? value) {
                  setState(() {
                    _enabled = value!;
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.thermostat,
                color: MyColor.primary7,
                size: 32,
              ),
              title: Text(
                AppLocalizations.of(context)!.units,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: InkWell(
                onTap: tempUnitExpanded,
                child: const Icon(
                  Icons.arrow_downward,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              height: _isExpanded2 ? 130 : 0,
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.cel,
                    ),
                    trailing: Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      onChanged: (val) {
                        setSelectedRadio(val as int);
                      },
                      activeColor: MyColor.additionalColor,
                    ),
                  ),
                  //Divider(),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.fah,
                    ),
                    trailing: Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      onChanged: (val) {
                        setSelectedRadio(val as int);
                      },
                      activeColor: MyColor.additionalColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
