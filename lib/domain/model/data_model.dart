import 'dart:convert';

class Weather {
  final String? name;
  final String? country;
  final String? localtime;

  final String? lastUpdated;
  final String? tempC;
  final String? conditionText;

  final String? windKph;
  final String? cloud;
  final String? humidity;
  final String? feelsLikeC;
  final String? uv;
  final String? pressure;

  Weather( 
      {this.name,
      this.country,
      this.localtime,
      this.lastUpdated,
      this.tempC,
      this.conditionText,
      this.windKph,
      this.cloud,
      this.humidity,
      this.feelsLikeC,
      this.uv,
      this.pressure,});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['location']['name'].toString(),
      country: json['location']['country'].toString(),
      localtime: json['location']['localtime'].toString(),
      lastUpdated: json['current']['last_updated'].toString(),
      tempC: json['current']['temp_c'].toString(),
      conditionText: json['current']['condition']['text'].toString(),
      windKph: json['current']['wind_kph'].toString(),
      cloud: json['current']['cloud'].toString(),
      humidity: json['current']['humidity'].toString(),
      feelsLikeC: json['current']['feelslike_c'].toString(),
      uv: json['current']['uv'].toString(),
      pressure: json['current']['pressure_mb'].toString()
    );
  }
}
