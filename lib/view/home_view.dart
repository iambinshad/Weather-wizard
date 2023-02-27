import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_wizard/constants/constants.dart';

import '../domain/model/data_model.dart';

final ValueNotifier<double> temperature = ValueNotifier<double>(0.0);
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _inputController = TextEditingController();
   Future<Weather?>? futureWeather;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 35, 96, 218),
        Color.fromARGB(255, 201, 4, 27),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Opacity(
          opacity: 0.8,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title:  CupertinoSearchTextField(
                controller: _inputController,
                placeholder: 'Search city',
                prefixIcon: Icon(Icons.search),
                backgroundColor: Colors.white,
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          textModel(text: 'Malappuram', size: 25),
                          kHeight10,
                          textModel(text: 'India', size: 27),
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
                            opacity: 0.4,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 300,
                              width: 300,
                            ),
                          )),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            height: 300,
                            width: 300,
                            child: Column(
                              children: [
                                kHeight15,
                                const Image(
                                  image: AssetImage(
                                    'assets/icons8-weather-64.png',
                                  ),
                                  height: 80,
                                  width: 100,
                                ),
                                kHeight10,
                                textModel(text: 'Cloudy', size: 40),
                                kHeight10,
                                textModel(text: '39', size: 140),
                              ],
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
                      weatherbox(imgIndex: 0, value: 25, item: 'Cloud'),
                      weatherbox(imgIndex: 1, value: 6.0, item: 'UV'),
                      weatherbox(imgIndex: 2, value: 25, item: 'Wind'),
                    ],
                  ),
                  kHeight15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      weatherbox(imgIndex: 3, value: 25, item: 'Pressure'),
                      weatherbox(imgIndex: 4, value: 6.0, item: 'Humidity'),
                      weatherbox(imgIndex: 5, value: 25, item: 'Feels Like'),
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
                            opacity: 0.4,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 60,
                              width: 335,
                            ),
                          )),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            height: 60,
                            width: 335,
                            child: Column(
                              children: [
                                ListTile(
                                  title: textModel(
                                      text:
                                          'Last Upadated :  2023-02-27   08:45',
                                      size: 20),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Stack weatherbox(
      {required int imgIndex, required double value, required String item}) {
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
          opacity: 0.4,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
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
                textModel(text: value.toString(), size: 18),
                textModel(text: item, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text textModel({required String text, double size = 25}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }
}
