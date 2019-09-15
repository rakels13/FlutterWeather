
class WeatherInformation {
  //Getting desired information from the Json response
  final String name;
  final String date;
  final String main;
  final double temp;
  final String icon;

  WeatherInformation({
    this.name,
    this.date,
    this.main,
    this.temp,
    this.icon
  });

  factory WeatherInformation.fromJson(Map<String, dynamic> json) {
    return WeatherInformation(
      name: json['city']['name'],
      date: json['list'][0]['dt_txt'],
      main: json['list'][0]['weather'][0]['main'],
      temp: json['list'][0]['main']['temp'].toDouble(),
      icon: json['list'][0]['weather'][0]['icon'],
    );
  }
}