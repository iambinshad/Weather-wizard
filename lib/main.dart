import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_wizard/view/current_weather_status.dart';
import 'package:weather_wizard/view/home_view.dart';

import 'infrastructure/weather_api/weather_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) =>WeatherApiClass() ,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OnTheLocationStatus(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
