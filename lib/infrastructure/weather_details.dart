import 'package:flutter/cupertino.dart';
import 'package:weather_wizard/domain/model/data_model.dart';

class WeatherDetails with ChangeNotifier {
  Weather? weather;

  set setWeather(Weather? data) {
    weather = data;
    notifyListeners();
  }

  void setrr(Weather? data) {
    weather = data;
    notifyListeners();
  }
}
