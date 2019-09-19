class ForecastInformation {

  // The items needed from the API response
  final List forecastList;
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

  ForecastInformation({
    // Constructor
    this.forecastList,
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

  factory ForecastInformation.fromJson(Map<String, dynamic> json) {
    // Parsing the Json response from the weather API and using list to hold them
    List list = new List();

    for (dynamic i in json['list']) {
      final DateTime dt = DateTime.parse(i['dt_txt']);

      ForecastInformation j = new ForecastInformation(
        name: json['city']['name'],
        date: dt,
        main: i['weather'][0]['main'],
        temp: i['main']['temp'].toInt(),
        icon: i['weather'][0]['icon'],
        tempMin: i['main']['temp_min'].toInt(),
        tempMax: i['main']['temp_max'].toInt(),
        humidity: i['main']['humidity'],
        description: i['weather'][0]['description'],
        wind: i['wind']['speed'].toDouble(),
      );
      list.add(j);
    }

    return ForecastInformation(
      forecastList: list,
    );
  }
}