import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherShimmer extends StatelessWidget {
  const WeatherShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.grey[500]!
          : Colors.grey[100]!,
      highlightColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.red[200]!
              : Colors.red[100]!,
      //period: Duration(seconds: 4),
      child: Card(
        child: SizedBox(width: 400, height: 200),
      ),
    );
  }
}
