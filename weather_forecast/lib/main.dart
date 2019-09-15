import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

Future<WeatherInformation> getWeather() async {
  final String uri = 'http://api.openweathermap.org/data/2.5/forecast?q=London,gb&appid=7a1fb19e16b5e885d8e1512b4ac571cd';
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    //Successful API call, parsing Json
    return WeatherInformation.fromJson(json.decode(response.body));
  } else {
    //Unsuccessful API call, throw error
    throw Exception('Failed to load weather');
  }
}

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

void main() => runApp(MyApp(data: getWeather()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<WeatherInformation> data;

  MyApp({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Forecast'),
        ),
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
        maxHeight: 100.0,
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
                          Text(snapshot.data.temp.toString()),
            
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

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
