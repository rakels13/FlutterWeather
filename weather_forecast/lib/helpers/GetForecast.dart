import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_forecast/models/ForecastInformation.dart';

Future<ForecastInformation> getForecast() async {
  // Future to hold the information from the weather API

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

    // Given the user's permission for use of geocoordinates
    uri = 'http://api.openweathermap.org/data/2.5/forecast?lat=${latitude.toString()}&lon=${longitude.toString()}&appid=7a1fb19e16b5e885d8e1512b4ac571cd&units=metric';
  }
  else {
    // No permission - Here the user should be prompted to search for a location
    uri = 'http://api.openweathermap.org/data/2.5/forecast?q=London,gb&appid=7a1fb19e16b5e885d8e1512b4ac571cd&units=metric';
  }
  final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      //Successful API call, parsing Json
      return ForecastInformation.fromJson(json.decode(response.body));
    } else {
      //Unsuccessful API call, throw error
      throw Exception('Failed to get weather forecast');
    }
}