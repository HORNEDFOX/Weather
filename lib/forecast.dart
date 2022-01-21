class Forecast {
  final DateTime date;
  final int temp;
  final String weather;

  Forecast({required this.date, required this.weather, required this.temp});

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
        temp: double.parse(json['main']['temp'].toString()).toInt(),
        weather: json['weather'][0]['main'] as String,
        date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  String getIconWeather()
  {
    if (weather == "Clouds") {
     if (date.hour >= 6 && date.hour <= 17) {
       return "assets/image/Cloud_Sun.svg";
     } else {
       return "assets/image/Cloud_Moon.svg";
     }
  }
    else if (weather == "Snow") {
      if (date.hour >= 6 && date.hour <= 17) {
        return "assets/image/Snow_Sun.svg";
      } else {
        return "assets/image/Snow_Moon.svg";
      }
    }

    else if (weather == "Clear") {
      if (date.hour >= 6 && date.hour <= 17) {
        return "assets/image/sunny.svg";
      } else {
        return "assets/image/Moon.svg";
      }
    }

    else if (weather == "Rain") {
      if (date.hour >= 6 && date.hour <= 17) {
        return "assets/image/Rain_Sun.svg";
      } else {
        return "assets/image/Rain_Moon.svg";
      }
    }

    return "";
  }

  String getEmojiWeather()
  {
    if (weather == "Clouds") return "☁";
    if (weather == "Snow") return "❄";
    if (weather == "Rain") return "☔";
    if (weather == "Clear") return "☀";
    return "?";
  }

  void display()
  {
    print("Погода: $weather");
    print("Температура: $temp°C");
    print("$date");
    print("\n______________________________________________\n");
  }

}