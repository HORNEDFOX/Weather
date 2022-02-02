import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/weatherBloc.dart';
import 'package:weather/weatherState.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:weather/colorBackground.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherEmptyState) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
          appBar: AppBar(
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            title: Text(
              "Forecast",
              style: TextStyle(
                color: const Color.fromRGBO(40, 40, 40, 0.8),
              ),
            ),
          ),
          body: EmptyState('Forecast Weather',
              'To download the weather for today and the next 5 days, you need to refresh the Today page by pulling it down.'),
        );
      }

      if (state is WeatherErrorState) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
          appBar: AppBar(
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            title: Text(
              "Forecast",
              style: TextStyle(
                color: const Color.fromRGBO(40, 40, 40, 0.8),
              ),
            ),
          ),
          body: EmptyState('Oops!',
              'Oops! Something went wrong.\nCheck your internet connection and geolocation on your device.'),
        );
      }

      if (state is WeatherLoadingState) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
          appBar: AppBar(
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            title: Text(
              "Forecast",
              style: TextStyle(
                color: const Color.fromRGBO(40, 40, 40, 0.8),
              ),
            ),
          ),
          body: Center(
            child: Text(
              'No data received',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      }

      if (state is WeatherLoadedState) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
          appBar: AppBar(
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            title: Text("${state.loadedWeather.city}",
                style: TextStyle(
                  color: const Color.fromRGBO(40, 40, 40, 0.8),
                )),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: colorBackground(state.loadedWeather.temp),
              ),
            ),
            child: GroupedListView<dynamic, DateTime>(
              elements: state.loadedForecast,
              groupBy: (item) => DateTime(
                item.date.year,
                item.date.month,
                item.date.day,
              ),
              groupSeparatorBuilder: (item) => Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.weekday == DateTime.now().weekday
                        ? 'Today'
                        : '${DateFormat('EEEE').format(item)} ',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  )),
              floatingHeader: true,
              itemComparator: (element1, element2) =>
                  element1.date.compareTo(element2.date),
              itemBuilder: (context, item) {
                return ForecastCard(
                    icon: '${item.getIconWeather()}',
                    weather: '${item.weather}',
                    temp: '${item.temp}',
                    time: '${item.date.hour}:${item.date.minute}0');
              },
            ),
          ),
        );
      }
      return Scaffold(
        backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          title: Text(
            "Forecast",
            style: TextStyle(
              color: const Color.fromRGBO(40, 40, 40, 0.8),
            ),
          ),
        ),
        body: Center(),
      );
    });
  }
}

class ForecastCard extends StatelessWidget {
  late final String weather;
  late final String temp;
  late final String time;
  late final String icon;

  ForecastCard(
      {required this.weather,
      required this.temp,
      required this.time,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: () => Center(
        child: Card(
          margin: EdgeInsets.fromLTRB(10.sp, 5.sp, 10.sp, 5.sp),
          elevation: 0.0,
          color: Color.fromRGBO(255, 255, 255, 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0.sp,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 20.0),
                            height: 55.0.sp,
                            width: 55.0.sp,
                            child: Center(
                              child: SvgPicture.asset(
                                "${icon}",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Container(
                              height: 45.sp,
                              width: 100.0.sp,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${time}',
                                style: TextStyle(
                                    fontSize: 23.sp, color: Colors.white),
                              ),
                            ),
                          ]),
                          Row(children: [
                            Container(
                              height: 35.0.sp,
                              width: 100.0.sp,
                              child: Text(
                                '${weather}',
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white),
                              ),
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        alignment: Alignment.centerRight,
                        height: 80.0.sp,
                        width: 80.0.sp,
                        child: Text(
                          '${temp}°',
                          style:
                              TextStyle(fontSize: 45.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
