import 'package:flutter/material.dart';
import 'package:weather_forecast/models/ForecastInformation.dart';
import 'package:weather_forecast/routes/DetailWeatherRoute.dart';
import 'package:weather_forecast/helpers/GetForecast.dart';
import 'package:intl/intl.dart';

class ForecastWeather extends StatelessWidget {  

  final Future<ForecastInformation> data = getForecast();
  final ind;

  ForecastWeather({this.ind});

  _getIndex (bi, i) {
    // Calculating the correct index to find the forecast for following days at noon
    
    if(i != null) {
      i = i*8;
    }
    switch (bi) {
      case '00':
      {
        return 12 + (i);
      }
      break;

      case '03':
      {
        return 11+ (i);
      }
      break;

      case '06':
      {
        return 10 + (i);
      }
      break;

      case '09':
      {
        return 9 + (i);
      }
      break;

      case '12':
      {
        return 8 + (i);
      }
      break;

      case '15':
      {
        return 7 + (i);
      }
      break;

      case '18':
      {
        return 6 + (i);
      }
      break;

      case '21':
      {
        return 5 + (i);
      }
      break;

      default:
      {
        return 0;
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int i;
    return GestureDetector(
        child: FutureBuilder<ForecastInformation>(
          future: getForecast(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int inde = _getIndex((DateFormat('H').format(snapshot.data.forecastList.elementAt(0).date)).toString(), ind);
              i = inde;
              return Padding(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(DateFormat('EEEE').format(snapshot.data.forecastList.elementAt(inde).date), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(DateFormat.yMMMMd("en_US").format(snapshot.data.forecastList.elementAt(inde).date)),
                        ],
                      )
                    ),
                    Image.network('https://openweathermap.org/img/wn/${snapshot.data.forecastList.elementAt(inde).icon}@2x.png'),
                    Container(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(children: <Widget>[
                        Text(snapshot.data.forecastList.elementAt(inde).temp.toString()+'°C ', style: TextStyle(fontSize: 20.0)),
                        Text(snapshot.data.forecastList.elementAt(inde).main),
                      ],)
                    ),
                  ],
                ),
              );
            }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailWeatherRoute(index: i)),
      );
    }
  );
  }
}