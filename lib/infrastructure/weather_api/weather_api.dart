import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_wizard/core/api_key/api_key.dart';

import '../../domain/model/data_model.dart';

class WeatherApiClass {
  List<Weather> weatherNotifier = [];
  static Future<Weather?> fetchWeatherDetails({required String searchCity,context}) async {
    Weather data;
    try {
      var cityy = searchCity;

      final url =
          'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityy&aqi=no';

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
    } catch (e) {
      log("not connected to internet $e");
      
      // showDialog(
      //     context: context,
      //     builder: ((context) => AlertDialog(
      //           content: Row(
      //             children: const [
      //               Text("Something went wrong..."),
      //               SizedBox(width: 15,),
      //               Icon(Icons
      //                   .signal_wifi_statusbar_connected_no_internet_4_sharp)
      //             ],
      //           ),
      //         )));
    }
    return null;
  }
}
