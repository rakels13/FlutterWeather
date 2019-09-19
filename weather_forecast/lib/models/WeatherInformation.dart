
class WeatherInformation {
  //Getting desired information from the Json response
  final String name;
  final DateTime date;
  final String main;
  final int temp;
  final String icon;
  final int tempMin;
  final int tempMax;
  final int humidity;
  final String description;
  final double wind;



  WeatherInformation({
    this.name,
    this.date,
    this.main,
    this.temp,
    this.icon,
    this.description,
    this.humidity,
    this.tempMax,
    this.tempMin,
    this.wind,
  });

  factory WeatherInformation.fromJson(Map<String, dynamic> json) {

    final DateTime dt = DateTime.parse(json['list'][0]['dt_txt']);

    return WeatherInformation(
      name: json['city']['name'],
      date: dt,
      main: json['list'][0]['weather'][0]['main'],
      temp: json['list'][0]['main']['temp'].toInt(),
      icon: json['list'][0]['weather'][0]['icon'],
      tempMin: json['list'][0]['main']['temp_min'].toInt(),
      tempMax: json['list'][0]['main']['temp_max'].toInt(),
      humidity: json['list'][0]['main']['humidity'],
      description: json['list'][0]['weather'][0]['description'],
      wind: json['list'][0]['wind']['speed'].toDouble(),
    );
  }
}