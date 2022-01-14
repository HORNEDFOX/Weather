class Weather{
  final String city;
  final String country;
  final int temp;
  final String weather;
  final int humidity;
  final int windSpeed;
  final double precipitation;
  final int wind;
  final int pressure;

  Weather({required this.city, required this.country, required this.weather, required this.temp, required this.humidity, required this.windSpeed, required this.wind, required this.pressure, required this.precipitation});

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      city: json['name'] as String,
      country: json['sys']['country'] as String,
      temp: double.parse(json['main']['temp'].toString()).toInt() as int,
      weather: json['weather'][0]['main'] as String,
      humidity: json['main']['humidity'] as int,
      windSpeed: double.parse(json['wind']['speed'].toString()).toInt() as int,
      precipitation: json['snow']['snow.1h'] == null ? 0 : json['snow']['snow.1h'] as double,
      wind: json['wind']['deg'] as int,
      pressure: json['main']['pressure'] as int,
    );
  }

  String windDirection()
  {
    if(wind == 360 || wind == 0)
      {
        return "N";
      }else if(wind > 0 && wind < 90)
        {
          return "NE";
        }else if(wind ==  90)
          {
            return "E";
          }else if(wind > 90 && wind < 180)
            {
              return "SE";
            }else if(wind == 180)
              {
                return "S";
              }else if(wind > 180 && wind < 270)
                {
                  return "SW";
                }else if(wind == 270)
                  {
                    return "W";
                  }else if(wind > 270 && wind < 360)
                    {
                      return "NW";
                    }

    return "No data";
  }

  void display()
  {
      print("Город: $city");
      print("Страна: $country");
      print("Погода: $weather");
      print("Температура: $temp°C");
      print("Влажность: $humidity%");
      print("Скорость ветра: $windSpeed km/h");
      print("Градусы: $wind");
      print("Осадки: $precipitation mm");
      print("Направление ветра: " + windDirection());
      print("Атмосферное давление: $pressure hPA");
  }
}