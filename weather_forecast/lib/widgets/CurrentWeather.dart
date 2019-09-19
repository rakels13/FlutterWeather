import 'package:flutter/material.dart';
import 'package:weather_forecast/models/ForecastInformation.dart';
import 'package:weather_forecast/helpers/GetForecast.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {  
  // The widget that displays the weather currently
  // Using a Futurebuilder that calls the future that holds the list of the data
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
                    child:  Text(snapshot.data.forecastList.elementAt(0).name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text(DateFormat('EEEE').format(DateTime.now()), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.network('https://openweathermap.org/img/wn/${snapshot.data.forecastList.elementAt(0).icon}@2x.png'),
                  ),
                  Expanded(
                    child: Text(snapshot.data.forecastList.elementAt(0).temp.toString()+'°C', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                  ), 
                  Expanded(
                    child: Text(DateFormat.yMMMMd("en_US").format(DateTime.now()), style: TextStyle(fontSize: 18)),
                  ),
                  Expanded(
                    child: Text(snapshot.data.forecastList.elementAt(0).main + ' - ' + snapshot.data.forecastList.elementAt(0).description, style: TextStyle(fontSize: 18),),
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