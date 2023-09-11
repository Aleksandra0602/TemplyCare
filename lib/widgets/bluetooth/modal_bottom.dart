import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:temp_app_v1/utils/constans/loading_widget.dart';

import 'package:temp_app_v1/utils/constans/my_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../screens/log_sign_screens/log_sign_screen.dart';

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
      if (mounted) {
        setState(() {
          devicesList.add(device);
        });
      }
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

  void connectDeviceMethod(
      BluetoothDevice element, BuildContext context) async {
    flutterBlue.stopScan();
    showLoadingWidget(context);

    await element.connect();
    _services = await element.discoverServices();

    setState(() {
      _connectedDevice = element;
      _services = _services;
    });
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) =>
            LogSignScreen(services: _services, device: _connectedDevice)),
      ),
    );
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
                    AppLocalizations.of(context)!.deviceConnect,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: MyColor.backgroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  icon: const Icon(
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
                .map(
                  (element) => Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: MyColor.backgroundColor,
                    shadowColor: MyColor.shadow,
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.bluetooth_searching,
                              color: MyColor.additionalColor.withOpacity(0.7),
                              size: 32,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  element.name == ''
                                      ? AppLocalizations.of(context)!
                                          .unknownDevice
                                      : element.name,
                                  style: const TextStyle(
                                      fontSize: 18, color: MyColor.primary1),
                                ),
                                Text(
                                  element.id.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => connectDeviceMethod(element, context),
                            // onTap: () async {
                            //   flutterBlue.stopScan();
                            //   try {
                            //     await element.connect();
                            //   } catch (e) {
                            //     if (e.hashCode.toString() !=
                            //         AppLocalizations.of(context)!
                            //             .alreadyConnected) {
                            //       throw e;
                            //     }
                            //   } finally {
                            //     _services = await element.discoverServices();
                            //   }
                            //   setState(() {
                            //     _connectedDevice = element;
                            //     _services = _services;
                            //   });

                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: ((context) =>
                            //           LogSignScreen(services: _services)),
                            //     ),
                            //   );
                            // },
                            child: Container(
                              height: 45,
                              width: 80,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MyColor.primary1,
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.connectDevice,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
