import 'package:flutter/material.dart';
import 'package:weather_forecast/widgets/MoreDetailWeather.dart';

class DetailWeatherRoute extends StatelessWidget {
  
  final int index;

  DetailWeatherRoute({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Weather'),
      ),
      body: MoreDetailWeather(index: index,),
    );
  }
}