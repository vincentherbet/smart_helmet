import 'package:flutter/material.dart';
import 'package:smarthelmet/homepage.dart';
import 'package:sqflite/sqflite.dart';

import 'database/helper/contacts_helper.dart';

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

  ContactHelper contactHelper = ContactHelper(db: database);
  runApp(
    Hertx(
      contactHelper: contactHelper,
    ),
  );
}

class Hertx extends StatelessWidget {
  final ContactHelper contactHelper;
  const Hertx({super.key, required this.contactHelper});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        //appBarTheme: AppBarTheme()
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.red,
          //unselectedItemColor: Colors.blueGrey
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomePage(
        contactHelper: contactHelper,
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