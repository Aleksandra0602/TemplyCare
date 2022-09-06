import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';


class RealTemperatureScreen extends StatefulWidget {
  
  
  final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

  @override
  State<RealTemperatureScreen> createState() => _RealTemperatureScreenState();
}

class _RealTemperatureScreenState extends State<RealTemperatureScreen> {
  
  List<double> trace = [];

  late Stream<List<int>> stream;
  late BluetoothCharacteristic characteristic;


  String _dataParser(List<int>? dataFromDevice) {
    if (dataFromDevice != null) {
      return utf8.decode(dataFromDevice);
    }
    return "null";
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktualne pomiary'),
        backgroundColor: Color.fromRGBO(0, 100, 100, 1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const Text('Tu będzie się wyświetlać temperatura i wilgotność'),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                child: Icon(Icons.start),
                style: OutlinedButton.styleFrom(primary: Colors.amber),
                onPressed: () async {
                  
                  characteristic.value.listen((value) {
                    widget.readValues[characteristic.uuid] = value;
                    
                  });
                  await characteristic.setNotifyValue(!characteristic.isNotifying);
                  stream = characteristic.value;
                },
              ),
              Container(
                child: const Text(
                  'Temperature 1',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
              ),
          
              // Container(
              //     child: StreamBuilder<List<int>>(
              //         stream: stream,
              //         builder: (BuildContext context,
              //             AsyncSnapshot<List<int>> snapshot) {
              //           if (snapshot.connectionState ==
              //               ConnectionState.active) {
              //             String currentVal = _dataParser(snapshot.data);
              //             trace.add((double.parse(currentVal)));
              //             return Row(
              //               children: <Widget>[
              //                 Text(currentVal != null
              //                     ? 'Value : ${currentVal}'
              //                     : 'Brak danych')
              //               ],
              //             );
              //           } else {
              //             return Text('Check Stream');
              //           }
              //         }),
              //   ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  'Temperature 2',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  'Humidity',
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
