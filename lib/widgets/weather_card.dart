import 'package:flutter/material.dart';

import '../network/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 200,
        width: 390,
        child: Column(
          children: [
            Text(
              'Chennai',
              style: TextStyle(fontSize: 27),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${weather.temperature}°C",
              style: TextStyle(fontSize: 45),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sunny',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
