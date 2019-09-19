import 'package:flutter/material.dart';
import 'package:weather_forecast/models/ForecastInformation.dart';
import 'package:weather_forecast/services/GetForecast.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {  

  final Future<ForecastInformation> data = getForecast();

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<ForecastInformation>(
      future: getForecast(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child:  Text(snapshot.data.forecastList.elementAt(0).name, style: TextStyle(fontSize: 18.0)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.network('https://openweathermap.org/img/wn/${snapshot.data.forecastList.elementAt(0).icon}@2x.png'),
                  ),
                  Expanded(
                    child: Text(DateFormat.yMMMMd("en_US").add_jm().format(DateTime.now())),
                  ),
                  Expanded(
                    child: Text(DateFormat('H').format(DateTime.now())),
                  ),
                  Expanded(
                    child: Text(snapshot.data.forecastList.elementAt(0).main),
                  ),
                  Expanded(
                    child: Text(snapshot.data.forecastList.elementAt(0).temp.toString()+'°C', style: TextStyle(fontSize: 22.0)),
                  ),               
                ],
              ),
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