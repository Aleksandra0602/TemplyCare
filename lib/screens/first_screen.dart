import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:temp_app_v1/screens/log_sign_screen.dart';

import '../widgets/screens.dart';

class FirstScreen extends StatefulWidget {
  final List<BluetoothDevice> devicesList = [];
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late BluetoothCharacteristic characteristic;

  late Stream<List<int>> stream;

  BluetoothDevice? _connectedDevice;
  List<BluetoothService>? _services;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  ListView buildListViewOfDevices() {
    List<Container> containers = [];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 60,
          child: Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                          device.name == '' ? '(unknown device)' : device.name),
                      Text(device.id.toString()),
                    ],
                  ),
                ),
                FlatButton(
                  color: Color.fromRGBO(0, 100, 100, 0.8),
                  child: Text(
                    'Connect',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    widget.flutterBlue.stopScan();

                    try {
                      await device.connect();
                    } catch (e) {
                      if (e.hashCode != 'already_connected') {
                        throw e;
                      }
                    } finally {
                      _services = await device.discoverServices();
                    }
                    setState(() {
                      _connectedDevice = device;
                      _services = _services;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('TemplyCare'),
      //   backgroundColor: const Color.fromRGBO(0, 25, 20, 0.8),
      // ),
      body: _connectedDevice != null
          ? LogSignScreen(
              services: _services,
            )
          : buildListViewOfDevices(),
    );
  }
}
