import 'package:weather/serviceWeather.dart';
import 'package:weather/weather.dart';
import 'forecast.dart';

class WeatherRepository {
  final WeatherService _weatherService = WeatherService();

  Future<Weather> getCurrentWeather(double lat, double lot) => _weatherService.fetchCurrentWeather(lat, lot);
  Future<List<Forecast>> getForecast(double lat, double lot) => _weatherService.fetchHourlyWeather(lat, lot);
}