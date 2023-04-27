import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/bluetooth_service.dart';

class BluetoothDeviceList extends StatelessWidget {
  final BluetoothDeviceService bluetoothService;
  const BluetoothDeviceList({super.key, required this.bluetoothService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BluetoothDevice>>(
      stream: bluetoothService.getResults(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        } else if (snapshot.hasData) {
          final devices = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return ListTile(
                title: Text(device.name),
                subtitle: Text(device.id.toString()),
              );
            },
          );
        }
        // else if (snapshot.hasError) {
        //   return Text('Error: ${snapshot.error}');
        // }
        else {
          return Text('Scanning for devices...');
        }
      },
    );
  }
}
