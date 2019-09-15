import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
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
        /*appBar: AppBar(
          title: Text('Weather Forecast'),
        ),*/
        backgroundColor: Colors.cyanAccent,
        body: SliverListView(),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent)
  {
     return new SizedBox.expand(child: child);
  }

    @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class SliverListView extends StatelessWidget {

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
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
