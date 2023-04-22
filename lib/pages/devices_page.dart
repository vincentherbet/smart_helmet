import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Helmet"),
        // backgroundColor: Colors.deepPurple,
      ),
      body: Card(
        child: SizedBox(
          height: 200,
          width: 400,
          child: Column(
            children: [
              Text('Weather',
                  style: TextStyle(
                      color: Color.fromARGB(255, 81, 101, 145), fontSize: 30))
            ],
          ),
        ),
      ),
    );
  }
}
