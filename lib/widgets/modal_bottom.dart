import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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
                const Expanded(
                  child: Text(
                    'Połącz się z urządzeniem',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 70, 60, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  icon: const Icon(
                    Icons.clear,
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
                      color: const Color.fromRGBO(235, 255, 235, 1),
                      shadowColor: const Color.fromRGBO(1, 100, 75, 0.8),
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
                                        fontSize: 14,
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
                                }
                                setState(() {
                                  _connectedDevice = element;
                                  _services = _services;
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => LogSignScreen(
                                            services: _services))));
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
