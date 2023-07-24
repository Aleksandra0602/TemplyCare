import 'package:flutter/material.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _enabled = true;
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
        title: const Text('Ustawienia'),
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
              title: const Text(
                'Język',
                style: TextStyle(
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
                    title: const Text(
                      'Polski',
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
                    title: const Text(
                      'Angielski',
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
              title: const Text(
                'Tryb ciemny',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                _enabled ? 'Włączony' : 'Wyłączony',
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
              title: const Text(
                'Jednostki metryczne',
                style: TextStyle(
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
                    title: const Text(
                      'Celsjusz',
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
                    title: const Text(
                      'Fahrenheit',
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
