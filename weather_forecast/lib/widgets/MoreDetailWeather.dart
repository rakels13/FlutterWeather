import 'package:flutter/material.dart';
import 'package:weather_forecast/models/ForecastInformation.dart';
import 'package:weather_forecast/services/GetForecast.dart';
import 'package:intl/intl.dart';

class MoreDetailWeather extends StatelessWidget {  

  final Future<ForecastInformation> data = getForecast();
  final int index;

  MoreDetailWeather({Key key, @required this.index}) : super(key: key);

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
                    child:  Text(snapshot.data.forecastList.elementAt(index*8).name, style: TextStyle(fontSize: 18.0)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.network('https://openweathermap.org/img/wn/${snapshot.data.forecastList.elementAt(index).icon}@2x.png'),
                  ),
                  Expanded(
                    child: Text(DateFormat.yMMMMd("en_US").format(snapshot.data.forecastList.elementAt(index*8).date)),
                  ),
                  Expanded(
                    child: Text(DateFormat('EEEE').format(snapshot.data.forecastList.elementAt(index*8).date)),
                  ),
                  Expanded(
                    child: Text(snapshot.data.forecastList.elementAt(index*8).main),
                  ),
                  Expanded(
                    child: Text(snapshot.data.forecastList.elementAt(index*8).temp.toString()+'°C', style: TextStyle(fontSize: 22.0)),
                  ),
                  Expanded(
                    child: Text('DETAILS'),
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