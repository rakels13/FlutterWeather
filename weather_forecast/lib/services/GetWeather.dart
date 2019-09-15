import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_forecast/models/WeatherInformation.dart';

Future<WeatherInformation> getWeather() async {
  Location userLocation = new Location();
  
  Map<String, double> currentLocation;

  var uri;

  try {
    currentLocation = await userLocation.getLocation();
  } catch (e) {
    currentLocation = null;
  }

  if (currentLocation != null) {
    final latitude = currentLocation['latitude'];
    final longitude = currentLocation['longitude'];

    uri = 'http://api.openweathermap.org/data/2.5/forecast?lat=${latitude.toString()}&lon=${longitude.toString()}&appid=7a1fb19e16b5e885d8e1512b4ac571cd&units=metric';
  }
  else {
    uri = 'http://api.openweathermap.org/data/2.5/forecast?q=London,gb&appid=7a1fb19e16b5e885d8e1512b4ac571cd&units=metric';
  }
  final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      //Successful API call, parsing Json
      return WeatherInformation.fromJson(json.decode(response.body));
    } else {
      //Unsuccessful API call, throw error
      throw Exception('Failed to load weather');
    }
}