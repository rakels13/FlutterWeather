import 'package:flutter/material.dart';
import 'package:weather_forecast/routes/DetailWeatherRoute.dart';
import 'package:weather_forecast/helpers/SliverAppBarDelegate.dart';
import 'package:weather_forecast/routes/SearchLocation.dart';
import 'package:weather_forecast/widgets/CurrentWeather.dart';
import 'package:weather_forecast/widgets/ForecastWeather.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(0, 158, 179, 1),
        body: SliverListView(),
      ),
    );
  }
}

class SliverListView extends StatelessWidget {
  // Homepage layout, one element grid with list below, using slivers
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 80.0,
        child: Container(
            color: Color.fromRGBO(38, 197, 218, 1), 
            child: Center( 
              child: Text(
                headerText,
                style: TextStyle(fontSize: 22.0), 
              )
            )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
            // search button in the appbar header to search for location
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchLocation()),
                  );
              },
            ),
          ],
          pinned: true,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Weather Forecast'),
          ),
        ),
        makeHeader('Current Weather'),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              //Builder for current weather, clickable
              return new GestureDetector(
                  // Calls the future builder for the currentweather information
                  child : CurrentWeather(),
                onTap: () {
                  Navigator.push(context,
                  // New route for more detail, baseIndex sent as parameter
                  MaterialPageRoute(builder: (context) => DetailWeatherRoute(index: 0,)),
                  );
                },
              );
            },
            childCount: 1,
          ),
        ),
        makeHeader('Following Days Forecast'),
        // Fixed list containing the following days' forecast
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return new ForecastWeather(ind: index);
          },
          // Display the four following days (in the 5 day forecast)
          childCount: 4,
          ),
        ),
      ],
    );
  }
}
