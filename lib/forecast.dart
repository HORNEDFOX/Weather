class Forecast {
  final DateTime? date;
  final int temp;
  final String weather;

  Forecast({this.date, required this.weather, required this.temp});

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
        temp: double.parse(json['main']['temp'].toString()).toInt(),
        weather: json['weather'][0]['main'] as String,
        date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
    );
  }

  void display()
  {
    print("Погода: $weather");
    print("Температура: $temp°C");
    print(date);
    print("\n______________________________________________\n");
  }

}