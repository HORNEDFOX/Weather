import 'package:flutter/material.dart';
import 'package:weather/forecastPage.dart';
import 'package:weather/todayPage.dart';

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
    TodayPage(), ForecastPage(),
  ];

  int _selectedIndex = 0;
  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
        unselectedItemColor: const Color.fromRGBO(113, 128, 154, 0.5),
        selectedItemColor: const Color.fromRGBO(74, 153, 230, 0.8),
        elevation: 2.0,
        onTap: _onItemTapped,
      ),
    );
  }
}
