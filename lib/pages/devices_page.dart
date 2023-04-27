import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthelmet/widgets/weather_card_shimmer.dart';

import '../network/helpers/weather_api_helper.dart';
import '../network/models/weather.dart';
import '../services/bluetooth_service.dart';
import '../widgets/weather_card.dart';
import 'bluetooth_device_list.dart';

class DevicesPage extends StatefulWidget {
  final WeatherApiHelper weatherApiHelper;
  final BluetoothDeviceService bluetoothService;
  const DevicesPage(
      {super.key,
      required this.weatherApiHelper,
      required this.bluetoothService});

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
        body: ListView(
          children: [
            FutureBuilder(
              future: widget.weatherApiHelper.getWeather(),
              builder: (context, AsyncSnapshot<Weather> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return WeatherCard(weather: data!);
                    // return Text(data!.temperature.toString());
                  }
                  if (snapshot.hasError) {
                    return Text('Got Error');
                  }
                }
                return WeatherShimmer();
              },
            ),
            BluetoothDeviceList(
              bluetoothService: widget.bluetoothService,
            )
          ],
        )
        // body: Card(
        //   child: SizedBox(
        //     height: 200,
        //     width: 400,
        //     child: Column(
        //       children: [
        //         Text(
        //           'Chennai',
        //           style: TextStyle(fontSize: 23),
        //         ),
        //         Text(
        //           '37 C',
        //           style: TextStyle(fontSize: 40),
        //         ),
        //         Text(
        //           'Sunny',
        //           style: TextStyle(fontSize: 30),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
