class WeatherState {}

class WeatherEmptyState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final dynamic loadedWeather;
  final List<dynamic> loadedForecast;

  WeatherLoadedState(
      {required this.loadedWeather, required this.loadedForecast})
      : assert(loadedWeather != null);
}

class WeatherErrorState extends WeatherState {}
