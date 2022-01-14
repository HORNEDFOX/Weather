import 'package:weather/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static String _apiKey = "d8313d90053c823b1fb6d1376a458e11";

  static Future<Weather> fetchCurrentWeather(double lat, double lon) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?&lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      Weather m = Weather.fromJson(json.decode(response.body));
      m.display();
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

}