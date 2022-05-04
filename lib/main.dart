import 'package:adsense/game_route.dart';
import 'package:adsense/home_route.dart';
import 'package:adsense/nextlevel_%20route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Monetization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeRoute(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeRoute(),
        '/game': (BuildContext conetxt) => new GameRoute(),
        '/nextleve': (BuildContext context) => new NextLevel(),

      },
    );
  }
}
