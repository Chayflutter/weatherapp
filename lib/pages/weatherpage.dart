import 'package:flutter/material.dart';
import 'package:myapp/modals/weatherModel.dart';
import 'package:myapp/services/weatherService.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = Weatherservice('c1afe0c55af9d30a5b57c55dea8715c1');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city "),
            Text("${_weather?.temperature.round()}°C"),
            ],
        ),
      ),
    );
  }
}
