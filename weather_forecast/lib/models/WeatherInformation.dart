
class WeatherInformation {
  //Getting desired information from the Json response
  final String name;
  final DateTime date;
  final String main;
  final int temp;
  final String icon;

  WeatherInformation({
    this.name,
    this.date,
    this.main,
    this.temp,
    this.icon
  });

  factory WeatherInformation.fromJson(Map<String, dynamic> json) {

    final DateTime dt = DateTime.parse(json['list'][0]['dt_txt']);

    return WeatherInformation(
      name: json['city']['name'],
      date: dt,
      main: json['list'][0]['weather'][0]['main'],
      temp: json['list'][0]['main']['temp'].toInt(),
      icon: json['list'][0]['weather'][0]['icon'],
    );
  }
}