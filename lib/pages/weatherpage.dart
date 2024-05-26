import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

String getWeatherAnimation(String? mainCondition){
  if(mainCondition == null )return 'assets/sunny.json';
  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'haze':
    case 'smoke':
    case 'dust':
    case 'fog':
    return 'assets/cloud.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
    return 'assets/rain.json';
    case 'thunderstorm':
    return 'assets/thunder.json';
    case 'clear':
    return 'assets/sunny.json';
    default:
    return 'assets/sunny.json';
      

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
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city", style: const TextStyle(color: Colors.white),),
            SizedBox(height: 30,),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            SizedBox(height: 30,),
            Text("${_weather?.temperature.round()}°C" , style: const TextStyle(color: Colors.white),),
            Text(_weather?.mainCondition ?? "Loading weather", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ],
        ),
      ),
    );
  }
}
