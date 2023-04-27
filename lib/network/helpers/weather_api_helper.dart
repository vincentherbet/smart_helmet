import 'dart:convert';

import '../models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiHelper {
  final http.Client client;
  const WeatherApiHelper(this.client);

  Future<Weather> getWeather() async {
    const API_URL =
        "https://api.open-meteo.com/v1/forecast?latitude=13.0827&longitude=80.2707&current_weather=true";
    final response = await client.get(Uri.parse(API_URL));

    final data = jsonDecode(response.body);

    return Weather.fromJson(data["current_weather"]);
  }
}
