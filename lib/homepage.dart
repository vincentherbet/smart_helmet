import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'database/helper/contacts_helper.dart';
import 'pages/devices_page.dart';
import 'pages/sos_page.dart';

class HomePage extends StatefulWidget {
  final ContactHelper contactHelper;
  const HomePage({super.key, required this.contactHelper});

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
      DevicesPage(),
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
