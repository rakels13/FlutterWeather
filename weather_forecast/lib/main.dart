import 'package:flutter/material.dart';
import 'package:weather_forecast/routes/DetailWeatherRoute.dart';
import 'package:weather_forecast/services/SliverAppBarDelegate.dart';
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
  // This widget is the root of your application.
  /*@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var forecastData = getForecast();
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData.light(),
      home: Scaffold(
        //backgroundColor: Colors.lightBlue,
        body: SliverListView(),
      ),
    );
  }
}

class SliverListView extends StatelessWidget {

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 80.0,
        child: Container(
            color: Colors.grey, 
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
              return new GestureDetector(
                child: Container(
                  child: CurrentWeather(),
                ),
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailWeatherRoute(index: 0,)),
                  );
                },
              );
            },
            childCount: 1,
          ),
        ),
        makeHeader('Weather Forecast for following days'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return new ForecastWeather(ind: index);
          },
          childCount: 4,
          ),
        ),
      ],
    );
  }
}
