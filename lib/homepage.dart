import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'database/helper/contacts_helper.dart';
import 'network/helpers/weather_api_helper.dart';
import 'pages/devices_page.dart';
import 'pages/sos_page.dart';
import 'services/bluetooth_service.dart';

class HomePage extends StatefulWidget {
  final ContactHelper contactHelper;
  final WeatherApiHelper weatherApiHelper;
  final BluetoothDeviceService bluetoothService;

  const HomePage(
      {super.key,
      required this.contactHelper,
      required this.weatherApiHelper,
      required this.bluetoothService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      DevicesPage(
        weatherApiHelper: widget.weatherApiHelper,
        bluetoothService: widget.bluetoothService,
      ),
      SosPage(
        contactHelper: widget.contactHelper,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.devices), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_emergency), label: "S.O.S")
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
      ),
      body: pages[currentIndex],
    );
  }
}
