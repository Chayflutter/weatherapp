import 'dart:convert';
import 'package:myapp/modals/weatherModel.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
class Weatherservice{
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
final String apiKey;

Weatherservice(this.apiKey);

Future<Weather> getWeather(String cityName)async{
  final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
  if(response.statusCode == 200){
    return Weather.fromJson(jsonDecode(response.body));
}else {
  throw Exception('Failed to load weather data');
}
}

Future <String> getCurrentCity()async{
  List <Placemark> placemarks = await placemarkFromCoordinates(6.9271, 79.8612);
  String? city = placemarks[0].locality;

  return city ?? "";
}
}