// ignore_for_file: avoid_print, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('6c22eef0f7d31742ab7a12360b03e3d5');
  Weather? _weather;

  //fetch weaather

  _fetchWeather() async {
    //city name
    String cityName = (await _weatherService.getCurrentCity()) as String;

    //city weather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any error
    catch (e) {
      print(e);
    }
  }

  //weather animation
  String getweatheranimation(String? maincondition) {
    if (maincondition == null) {
      return 'assets/weather sunny.json';
    }
    switch (maincondition) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
      case 'dust':
        return 'assets/weather raining.json';
      case 'Rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/weather sunny and raining.json';
      case 'thunderstrome':
        return 'assets/weather lightining and raining.json';
      case 'clear':
        return 'assets/weather sunny.json';
      default:
        return 'assets/weather sunny.json';
    }
  }

  //initial state
  @override
  void initState() {
    super.initState();

    //fetch the weather

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityname ?? "loading city ..."),

            // animation
            Lottie.asset(getweatheranimation(_weather?.mainCondition)),

            //temperature
            Text('${_weather?.temperature.round()}ºC'),

            //weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
