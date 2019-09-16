 import 'package:flutter/material.dart';
import 'package:weather_forecast/models/ForecastInformation.dart';
import 'package:weather_forecast/services/GetForecast.dart';

class ForecastWeather extends StatelessWidget {  

  final Future<ForecastInformation> data = getForecast();
  final int index;

  ForecastWeather({this.index});

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<ForecastInformation>(
      future: getForecast(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
            children: <Widget>[
              //Text(snapshot.data.name, style: TextStyle(fontSize: 18.0)),
              Image.network('https://openweathermap.org/img/wn/${snapshot.data.forecastList.elementAt(index*8).icon}@2x.png'),
              Text(snapshot.data.forecastList.elementAt(index*8).date),
              Text(snapshot.data.forecastList.elementAt(index*8).main),
              Text(snapshot.data.forecastList.elementAt(index*8).temp.toString()),
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