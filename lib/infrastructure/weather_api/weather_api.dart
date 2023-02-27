import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_wizard/core/api_key/api_key.dart';

import '../../domain/model/data_model.dart';
 
 class WeatherApiClass extends ChangeNotifier{
  
Future<Weather?> fetchWeatherDetails({required String city}) async {
  Weather data;

  var cityy = city;

  final url = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200 || response.statusCode == 201) {
    //here covert object to json string
    final bodyAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    log(response.body);

    data = Weather.fromJson(bodyAsJson);
    return data;
  } else {
    throw Exception('Failed to fetch weather data');
  }
}

 }