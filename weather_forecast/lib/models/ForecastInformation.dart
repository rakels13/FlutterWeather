import 'package:weather_forecast/models/WeatherInformation.dart';

class ForecastInformation {
  //Getting desired information from the Json response
  final List forecastList;

  ForecastInformation({
    this.forecastList,
  });

  factory ForecastInformation.fromJson(Map<String, dynamic> json) {
    List list = new List();

    for (dynamic i in json['list']) {
      WeatherInformation j = new WeatherInformation(
        date: i['dt_txt'],
        main: i['weather'][0]['main'],
        temp: i['main']['temp'].toDouble(),
        icon: i['weather'][0]['icon'],
      );
      list.add(j);
    }

    return ForecastInformation(
      forecastList: list,
    );
  }
}