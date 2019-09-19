import 'package:flutter/material.dart';
import 'package:weather_forecast/widgets/MoreDetailWeather.dart';

class DetailWeatherRoute extends StatelessWidget {
  // Page that shows more detail about the weatherforecast
  
  final int index;

  DetailWeatherRoute({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Weather'),
      ),
      backgroundColor: Color.fromRGBO(0, 158, 179, 1),
      body: MoreDetailWeather(index: index),
    );
  }
}