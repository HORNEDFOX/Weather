import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}


  class _ForecastPageState extends State<ForecastPage>
  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: const Color.fromRGBO(74, 153, 230, 0.8),
        title: const Text("Forecast"),
      ),
    );
  }
}
