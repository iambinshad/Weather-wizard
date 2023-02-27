import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_wizard/domain/model/data_model.dart';
import 'package:weather_wizard/infrastructure/weather_api/weather_api.dart';

final ValueNotifier<double> temperature = ValueNotifier<double>(0.0);

class OnTheLocationStatus extends StatelessWidget {
  OnTheLocationStatus({super.key});

  final _inputController = TextEditingController();

  Future<Weather?>? futureWeather;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 4, 125, 225),
          Color.fromARGB(255, 130, 156, 178),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _inputController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final city = _inputController.text;

                          futureWeather = Provider.of<WeatherApiClass>(context)
                              .fetchWeatherDetails(city: city);
                        },
                        icon: const Icon(Icons.search)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(39))),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<Weather?>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final result = snapshot.data;

                    double tempDouble = double.parse(result!.tempC ?? "0.0");
                    temperature.value = tempDouble;
                    return Column(
                      children: [
                        Text(
                          '${result.country}',
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Roboto'),
                        ),
                        Text(
                          '${result.name}',
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Roboto'),
                        ),
                        Text(
                          '${result.lastUpdated}',
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Roboto'),
                        ),
                        Text(
                          '${result.conditionText}',
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Roboto'),
                        ),
                        Text(
                          '${result.humidity}',
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Roboto'),
                        ),
                        Text(
                          '${result.localtime}',
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Roboto'),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error :${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: Text('Search a city'),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Center(
                      child: Text('Something went Wrong'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
