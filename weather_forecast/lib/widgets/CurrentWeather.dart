import 'package:flutter/material.dart';
import 'package:weather_forecast/models/WeatherInformation.dart';
import 'package:weather_forecast/services/GetWeather.dart';

class CurrentWeather extends StatelessWidget {  

  final Future<WeatherInformation> data = getWeather();

  //CurrentWeather({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<WeatherInformation>(
      future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
            children: <Widget>[
              Text(snapshot.data.name, style: TextStyle(fontSize: 18.0)),
              Image.network('https://openweathermap.org/img/wn/${snapshot.data.icon}@2x.png'),
              Text(snapshot.data.date),
              Text(snapshot.data.main),
              Text(snapshot.data.temp.toString()+'°C'),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}