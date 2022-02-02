import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/forecastPage.dart';
import 'package:weather/todayPage.dart';
import 'package:weather/weatherBloc.dart';
import 'package:weather/weatherRepository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  final List<Widget> _screens = [
    TodayPage(),
    ForecastPage(),
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  final weatherRepository = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(weatherRepository),
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: _screens,
                  onPageChanged: _onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.light_mode),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_cloudy),
              label: 'Forecast',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: const Color.fromRGBO(80, 80, 80, 0.4),
          selectedItemColor: const Color.fromRGBO(40, 40, 40, 0.8),
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          elevation: 0.0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
