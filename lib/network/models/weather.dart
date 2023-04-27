class Weather {
  final double temperature;
  final int code;

  const Weather({required this.temperature, required this.code});

  factory Weather.fromJson(Map<dynamic, dynamic> json) {
    return Weather(
      temperature: json['temperature'],
      code: json['weathercode'],
    );
  }
}
