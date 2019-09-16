import 'package:flutter/material.dart';
import 'package:weather_forecast/models/WeatherInformation.dart';
import 'package:weather_forecast/services/GetWeather.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {  

  final Future<WeatherInformation> data = getWeather();

  //CurrentWeather({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<WeatherInformation>(
      future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child:  Text(snapshot.data.name, style: TextStyle(fontSize: 18.0)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.network('https://openweathermap.org/img/wn/${snapshot.data.icon}@2x.png'),
                  ),
                  Expanded(
                    child: Text(DateFormat.yMMMMd("en_US").format(DateTime.now())),
                  ),
                  Expanded(
                    child: Text(DateFormat('EEEE').format(DateTime.now())),
                  ),
                  Expanded(
                    child: Text(snapshot.data.main),
                  ),
                  Expanded(
                    child: Text(snapshot.data.temp.toString()+'°C', style: TextStyle(fontSize: 22.0)),
                  ),               
                ],
              )
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