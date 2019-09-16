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
      final DateTime dt = DateTime.parse(i['dt_txt']);

      WeatherInformation j = new WeatherInformation(
        date: dt,
        main: i['weather'][0]['main'],
        temp: i['main']['temp'].toInt(),
        icon: i['weather'][0]['icon'],
      );
      list.add(j);
    }

    return ForecastInformation(
      forecastList: list,
    );
  }
}