import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:smarthelmet/homepage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'database/helper/contacts_helper.dart';
import 'network/helpers/weather_api_helper.dart';
import 'services/bluetooth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var databasesPath = await getDatabasesPath();
  String path = databasesPath + 'contacts.db';
  Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Contact (id INTEGER PRIMARY KEY, name TEXT, phone TEXT)');
    },
  );

  http.Client client = http.Client();

  final flutterBlue = FlutterBluePlus.instance;

  Location location = Location();

  ContactHelper contactHelper = ContactHelper(db: database);

  WeatherApiHelper weatherApiHelper = WeatherApiHelper(client);

  BluetoothDeviceService bluetoothService = BluetoothDeviceService(flutterBlue);

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
  runApp(
    Hertx(
      contactHelper: contactHelper,
      weatherApiHelper: weatherApiHelper,
      bluetoothService: bluetoothService,
    ),
  );
}

class Hertx extends StatelessWidget {
  final ContactHelper contactHelper;
  final WeatherApiHelper weatherApiHelper;
  final BluetoothDeviceService bluetoothService;

  const Hertx(
      {super.key,
      required this.contactHelper,
      required this.weatherApiHelper,
      required this.bluetoothService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,

        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.red[50],
        //appBarTheme: AppBarTheme()
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
          //backgroundColor: Colors.red
          //scaffoldBackgroundColor:Colors.red[100;]
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.red,

          //unselectedItemColor: Colors.blueGrey
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomePage(
        contactHelper: contactHelper,
        weatherApiHelper: weatherApiHelper,
        bluetoothService: bluetoothService,
      ),
    );
  }
}




//  Container(
//           color: Colors.black,
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 80,
//               vertical: 16,
//             ),
//             child: GNav(
//                 backgroundColor: Colors.black,
//                 color: Colors.grey,
//                 activeColor: Colors.white,
//                 tabBackgroundColor: Color.fromARGB(255, 131, 91, 201),
//                 padding: EdgeInsets.all(16),
//                 gap: 8,
//                 iconSize: 24,
//                 haptic: true,
//                 tabBorderRadius: 20,
//                 onTabChange: (index) {
//                   print(index);
//                 },
//                 tabs: const [
//                   GButton(
//                     icon: Icons.devices,
//                     text: 'Devices',
//                   ),
//                   GButton(
//                     icon: Icons.contact_emergency,
//                     text: ' S.O.S',
//                   ),
//                 ]),
//           ),
//         ),