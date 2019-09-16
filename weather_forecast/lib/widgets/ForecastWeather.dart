import 'package:flutter/material.dart';
import 'package:weather_forecast/models/ForecastInformation.dart';
import 'package:weather_forecast/services/GetForecast.dart';
import 'package:intl/intl.dart';

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
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: <Widget>[
                        Text(DateFormat('EEEE').format(snapshot.data.forecastList.elementAt(index*8).date)),
                        Text(DateFormat.yMMMMd("en_US").format(snapshot.data.forecastList.elementAt(index*8).date)),
                      ],)
                  ),
                  Image.network('https://openweathermap.org/img/wn/${snapshot.data.forecastList.elementAt(index*8).icon}@2x.png'),
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(children: <Widget>[
                      Text(snapshot.data.forecastList.elementAt(index*8).temp.toString()+'°C ', style: TextStyle(fontSize: 20.0)),
                      Text(snapshot.data.forecastList.elementAt(index*8).main),
                    ],)
                  ),
                  
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