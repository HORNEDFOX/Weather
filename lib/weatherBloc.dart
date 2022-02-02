import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/forecast.dart';
import 'package:weather/weather.dart';
import 'package:weather/weatherEvent.dart';
import 'package:weather/weatherRepository.dart';
import 'package:weather/weatherState.dart';

import 'geolocatioan.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherEmptyState()) {
    on<WeatherRefreshEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final Position position = await getGeoLocationPosition();
        final Weather _loadedWeather = await weatherRepository
            .getCurrentWeather(position.latitude, position.longitude);
        final List<Forecast> _loadedForecast = await weatherRepository
            .getForecast(position.latitude, position.longitude);
        emit(WeatherLoadedState(
            loadedWeather: _loadedWeather, loadedForecast: _loadedForecast));
      } catch (_) {
        emit(WeatherErrorState());
      }
    });
  }
}
