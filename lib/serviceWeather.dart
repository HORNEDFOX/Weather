import 'package:weather/weather.dart';
import 'package:weather/forecast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  String _apiKey = "d8313d90053c823b1fb6d1376a458e11";

  Future<Weather> fetchCurrentWeather(double lat, double lon) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    final response = await http.post(Uri.parse(url));

    print(lat);
    print(lon);

    if (response.statusCode == 200) {
      Weather m = Weather.fromJson(json.decode(response.body));
      m.display();
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<Forecast>> fetchHourlyWeather(double lat, double lon) async {
    var url =
        'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Forecast> data = (jsonData['list'] as List<dynamic>)
          .map((item) {
        Forecast l = Forecast.fromJson(item);
        l.display();
        return Forecast.fromJson(item);
      }).toList();
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }

}