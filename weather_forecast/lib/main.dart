import 'package:flutter/material.dart';
import 'dart:async';


import 'package:weather_forecast/models/WeatherInformation.dart';
import 'package:weather_forecast/services/GetWeather.dart';
import 'package:weather_forecast/services/SliverAppBarDelegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  
  final Future<WeatherInformation> data = getWeather();

  //MyAppState({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.cyanAccent,
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
            color: Colors.lightBlue, 
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
              return new Container(
                child: FutureBuilder<WeatherInformation>(
                  future: getWeather(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Text(snapshot.data.name, style: TextStyle(fontSize: 18.0)),
                          Image.network('https://openweathermap.org/img/wn/${snapshot.data.icon}@2x.png'),
                          Text(snapshot.data.date),
                          Text(snapshot.data.main),
                          Text(snapshot.data.temp.toString()+'°C'),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              );
            },
            childCount: 1,
          ),
        ),
        makeHeader('Weather Forecast for following days'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
            ],
          ),
        ),
      ],
    );
  }
}
