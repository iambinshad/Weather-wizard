import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_wizard/constants/constants.dart';
import 'package:weather_wizard/infrastructure/weather_api/weather_api.dart';
import 'package:weather_wizard/infrastructure/weather_details.dart';

import '../domain/code/debouncer/debouncer.dart';
import '../domain/model/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _inputController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1 * 1000);
  Future<Weather?>? futureWeather;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 4, 83, 241),
        Color.fromARGB(255, 2, 136, 246),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Opacity(
          opacity: 0.8,
          child: Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              title: CupertinoSearchTextField(
                onChanged: (value) async {
                  _debouncer.run(() async {
                    Weather? weatherResult =
                        await WeatherApiClass.fetchWeatherDetails(
                            searchCity: _inputController.text);
                    Provider.of<WeatherDetails>(context, listen: false)
                        .setWeather = weatherResult;
                  });
                },
                controller: _inputController,
                placeholder: 'Search city',
                prefixIcon: const Icon(Icons.search),
                backgroundColor: Colors.white,
              ),
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Consumer<WeatherDetails>(
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Consumer<WeatherDetails>(
                                      builder: (context, value, child) {
                                    return _inputController != null
                                        ? textModel(
                                            text: _inputController.text,
                                            size: 27)
                                        : const Text(
                                            'Search Your City Weather',
                                          );
                                  }),
                                  kHeight10,
                                  Consumer<WeatherDetails>(
                                      builder: (context, value, child) {
                                    return value.weather != null
                                        ? textModel(
                                            text: "${value.weather!.country}",
                                            size: 27)
                                        : const Text('0,0');
                                  }),
                                ],
                              )
                            ],
                          ),
                          kHeight10,
                          textModel(text: "Today's Report"),
                          kHeight25,
                          kHeight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                      child: Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 12, 54, 88),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 300,
                                      width: 300,
                                    ),
                                  )),
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 300,
                                      width: 300,
                                      child: Column(
                                        children: [
                                          kHeight15,
                                          const Image(
                                              image: AssetImage(
                                                  'assets/icons8-weather-66.png')),
                                          // Image.network(
                                          //   'http:${value.weather?.icon}',
                                          // ),
                                          kHeight10,
                                          bigBoxConsumer(
                                              item:
                                                  value.weather?.conditionText,
                                              size: 30),
                                          kHeight10,
                                          Consumer<WeatherDetails>(
                                              builder: (context, value, child) {
                                            return value.weather != null
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      textModel(
                                                          text:
                                                              "${value.weather!.tempC}",
                                                          size: 100),
                                                      textModel(
                                                          text: '\u00B0',
                                                          size: 80),
                                                    ],
                                                  )
                                                : const Text('0,0');
                                          }),
                                          bigBoxConsumer(
                                              item: value.weather?.localtime,
                                              size: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          kHeight25,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Consumer<WeatherDetails>(
                                builder: (context, value, child) {
                                  return weatherbox(
                                      imgIndex: 0,
                                      value: '${value.weather?.cloud}',
                                      item: 'Cloud');
                                },
                              ),
                              Consumer<WeatherDetails>(
                                builder: (context, value, child) {
                                  return weatherbox(
                                      imgIndex: 1,
                                      value: '${value.weather?.uv}',
                                      item: 'UV');
                                },
                              ),
                              Consumer<WeatherDetails>(
                                builder: (context, value, child) {
                                  return weatherbox(
                                      imgIndex: 2,
                                      value: '${value.weather?.windKph}',
                                      item: 'Wind');
                                },
                              ),
                            ],
                          ),
                          kHeight15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Consumer<WeatherDetails>(
                                builder: (context, value, child) {
                                  return weatherbox(
                                      imgIndex: 3,
                                      value: '${value.weather?.pressure}',
                                      item: 'Pressure');
                                },
                              ),
                              Consumer<WeatherDetails>(
                                builder: (context, value, child) {
                                  return weatherbox(
                                      imgIndex: 4,
                                      value: '${value.weather?.humidity}',
                                      item: 'Humidity');
                                },
                              ),
                              Consumer<WeatherDetails>(
                                builder: (context, value, child) {
                                  return weatherbox(
                                      imgIndex: 5,
                                      value: '${value.weather?.feelsLikeC}',
                                      item: 'Feels Like');
                                },
                              ),
                            ],
                          ),
                          kHeight15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                      child: Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 12, 54, 88),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 60,
                                      width: 335,
                                    ),
                                  )),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 60,
                                    width: 335,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Consumer<WeatherDetails>(
                                            builder: (context, value, child) {
                                              return Center(
                                                child: textModel(
                                                    text:
                                                        'Last Upadated : ${value.weather?.lastUpdated}',
                                                    size: 20),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  )),
            ),
          )),
    );
  }

  Consumer<WeatherDetails> bigBoxConsumer(
      {required var item, required double size}) {
    return Consumer<WeatherDetails>(builder: (context, value, child) {
      return value.weather != null
          ? Center(
              child: textModel(text: item, size: size),
            )
          : const Text('0,0');
    });
  }

  Stack weatherbox(
      {required int imgIndex, required var value, required String item}) {
    var img = [
      'assets/icons8-happy-cloud-48.png',
      'assets/icons8-uv-index-64.png',
      'assets/icons8-wind-48.png',
      'assets/icons8-pressure-48.png',
      'assets/icons8-dew-point-48.png',
      'assets/icons8-weather-forecast-48.png'
    ];
    return Stack(
      children: [
        Positioned(
            child: Opacity(
          opacity: 0.8,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 12, 54, 88),
                borderRadius: BorderRadius.circular(10)),
            height: 90,
            width: 90,
          ),
        )),
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          height: 90,
          width: 90,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage(img[imgIndex]),
                  height: 40,
                  width: 40,
                ),
                textModel(
                  text: value.toString(),
                  size: 18,
                ),
                textModel(
                    text: item,
                    size: 18,
                    color: const Color.fromARGB(255, 228, 227, 227)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text textModel(
      {required String text, double size = 25, color = Colors.white}) {
    return Text(
      text,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: size,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: color),
    );
  }
}
