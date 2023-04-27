import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDeviceService {
  final FlutterBluePlus flutterBlue;

  const BluetoothDeviceService(this.flutterBlue);

  void startScanning() async {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.stopScan();
  }

  void stopScanning() {
    flutterBlue.stopScan();
  }

  Stream<List<BluetoothDevice>> getResults() {
    startScanning();
    return flutterBlue.scanResults.map((scanResult) {
      return scanResult.map((result) => result.device).toList();
    });
  }
}
