import 'package:flutter/material.dart';

class SearchLocation extends StatefulWidget {
  // TODO implement search for location
  // Here there should be an option for entering a city name and perhaps a drop down list
  // that represents ISO3166 country codes needed for the API call

  @override
  State<StatefulWidget> createState() {
    return new SearchLocationState();
  }
  
}
  
class SearchLocationState extends State<SearchLocation> {

  String cityName = '';
  String countryCode = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement the return of information
    // and change the input for countrycodes
    return new Scaffold(
      appBar: new AppBar(title: new Text('Search for city Weather Forecast')),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('This is under construction'),
            new TextField(
              decoration: InputDecoration(
                hintText: 'Enter name of City'
              ),
              onChanged: (String city) {
                setState(() {
                  cityName = city;
                });
              },
            ),
            new TextField(
              decoration: InputDecoration(
                hintText: 'Enter ISO3166 countrycode for the city'
              ),
              onChanged: (String country) {
                setState(() {
                  countryCode = country;
                });
              },
            ),
          ],
        ),
        ),
    );
  }

}