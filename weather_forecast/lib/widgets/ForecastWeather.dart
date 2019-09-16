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
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(snapshot.data.forecastList.elementAt(index*8).main),
                  Container(
                    child: Column(children: <Widget>[
                      Image.network('https://openweathermap.org/img/wn/${snapshot.data.forecastList.elementAt(index*8).icon}@2x.png'),
                      Text(snapshot.data.forecastList.elementAt(index*8).date),
                    ],)
                  ),
                  Text(snapshot.data.forecastList.elementAt(index*8).temp.toString()+'°C ', style: TextStyle(fontSize: 20.0)),
                ],
              ),
            );
          }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}