import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/utils/constans/my_color.dart';

import '../screens/log_sign_screen.dart';

class ModalBottomBody extends StatefulWidget {
  const ModalBottomBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ModalBottomBody> createState() => _ModalBottomBodyState();
}

class _ModalBottomBodyState extends State<ModalBottomBody> {
  final List<BluetoothDevice> devicesList = [];
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  late BluetoothCharacteristic characteristic;

  late Stream<List<int>> stream;

  BluetoothDevice? _connectedDevice;
  List<BluetoothService>? _services;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan(timeout: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Połącz się z urządzeniem',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColor.backgroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  icon: Icon(
                    Icons.clear,
                    color: MyColor.backgroundColor,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: devicesList
                .map((element) => Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      color: MyColor.backgroundColor,
                      shadowColor: MyColor.primary3,
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    element.name == ''
                                        ? 'Nieznane urządzenie'
                                        : element.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    element.id.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                flutterBlue.stopScan();
                                try {
                                  await element.connect();
                                } catch (e) {
                                  if (e.hashCode != 'already_connected') {
                                    throw e;
                                  }
                                } finally {
                                  _services = await element.discoverServices();
                                  print(_services.toString());
                                }
                                setState(() {
                                  _connectedDevice = element;
                                  _services = _services;

                                  print(_services!.last);
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        LogSignScreen(services: _services)),
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                width: 80,
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(0, 60, 50, 1),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Połącz',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
