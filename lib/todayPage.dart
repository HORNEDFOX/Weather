import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/weatherBloc.dart';
import 'package:weather/weatherEvent.dart';
import 'package:weather/weatherState.dart';
import 'package:share/share.dart';

late WeatherLoadedState state;


class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage>
{
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
          appBar: AppBar(
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            title: const Text("Today", style: TextStyle(color: const Color.fromRGBO(40, 40, 40, 0.8),),),
          ),
          body: todayBodyPage(),
        );
      }
}

class todayBodyPage extends StatelessWidget {
  const todayBodyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = context.read<WeatherBloc>();
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherEmptyState) {
              return Center(
              child: ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                builder: () => RefreshIndicator(
                            onRefresh: () async {
                              return weatherBloc.add(WeatherRefreshEvent());
                            },
                            child: Stack(
                                children: <Widget>[
                                      ListView(),
                                  Center(
                                  child: Text(
                                    'No data received',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  ),
                                ]
                            ),
                      ),
            ),
            );
          }

          if(state is WeatherLoadingState)
          {
                return Center(
          child: ScreenUtilInit(
            designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            minTextAdapt: true,
          builder: () => RefreshIndicator(
                      onRefresh: () async {
                       return weatherBloc.add(WeatherRefreshEvent());
                      },
                      child: Stack(
                          children: <Widget>[
                                ListView(),
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                          ]
                      ),
                ),
          ),
          );
          }

          if(state is WeatherLoadedState)
          {
                return ScreenUtilInit(
          designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
          minTextAdapt: true,
          builder: () => RefreshIndicator(
                      onRefresh: () async {
                        return weatherBloc.add(WeatherRefreshEvent());
                      },
                      child: Stack(
                            children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: state.loadedWeather.temp <= 15 ? ([
                                            const Color.fromRGBO(167, 112, 239, 1),
                                            const Color.fromRGBO(207, 139, 243, 1),
                                            const Color.fromRGBO(253, 185, 155, 1),
                                          ]) : [
                                            const Color.fromRGBO(255, 95, 109, 1),
                                            const Color.fromRGBO(255, 195, 113, 1),
                                          ],
                                        )
                                    ),
                                  ),
                              ListView(),
                                  Center(
                                        child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                        Row(
                                                              children: [
                                                                    Container(
                                                                      margin: EdgeInsets.fromLTRB(0,0,0,30.0),
                                                                          child: SizedBox(
                                                                                width: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .width,
                                                                                child: SvgPicture
                                                                                    .asset(
                                                                                  "${state.loadedWeather.getIconWeather()}",
                                                                                      width: 170.w,
                                                                                  color: Colors.white,
                                                                                ),
                                                                          ),
                                                                    ),
                                                              ],
                                                        ),
                                                        Row(
                                                              children: [
                                                                    Container(
                                                                          margin: EdgeInsets
                                                                              .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child: SizedBox(
                                                                              width: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .width,
                                                                              child: Text('${state.loadedWeather.city}, ${state.loadedWeather.country}',
                                                                                    textAlign: TextAlign
                                                                                        .center,
                                                                                    style: TextStyle(
                                                                                        fontSize: 30.sp,
                                                                                        color: Colors.white),)
                                                                          ),
                                                                    ),
                                                              ],
                                                        ),
                                                        Row(
                                                              children: [
                                                                    Container(
                                                                          child: SizedBox(
                                                                                width: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .width,
                                                                                child: Text(
                                                                                      "${state.loadedWeather.temp}° ${state.loadedWeather.weather}",
                                                                                      textAlign: TextAlign
                                                                                          .center,
                                                                                      style: TextStyle(
                                                                                          fontSize: 45.sp,
                                                                                          color: Colors.white),),
                                                                          ),
                                                                    ),
                                                              ],
                                                        ),
                                                        Container(
                                                              margin: EdgeInsets.fromLTRB(70, 10, 70,30),
                                                              padding: EdgeInsets.fromLTRB(0, 15, 0,15),
                                                          decoration: BoxDecoration(
                                                            color: Color.fromRGBO(255, 255, 255, 0.2),
                                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                                          ),
                                                              child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                          Container(
                                                                                height: 170.0.h,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .topCenter,
                                                                                                        margin: EdgeInsets.symmetric(vertical: 10.0.h),
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/drop-cloud.svg",
                                                                                                                  height: 40.h,

                                                                                                            ),),
                                                                                                ],
                                                                                          ),
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .topCenter,
                                                                                                            child: Text(
                                                                                                                "${state.loadedWeather.humidity}%"),),
                                                                                                ],
                                                                                          ),
                                                                                    ]
                                                                                ),
                                                                          ),
                                                                          Container(
                                                                            height: 170.0.h,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .end,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .bottomCenter,
                                                                                                        margin: EdgeInsets.symmetric(vertical: 10.0.h),
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/wind.svg",
                                                                                                                  height: 40.h,

                                                                                                            ),),
                                                                                                ],
                                                                                          ),
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .topCenter,
                                                                                                            child: Text(
                                                                                                                "${state.loadedWeather.windSpeed} km/h"),),
                                                                                                ],
                                                                                          ),
                                                                                    ]
                                                                                ),
                                                                          ),
                                                                          Container(
                                                                            height: 170.0.h,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .topCenter,
                                                                                                        margin: EdgeInsets.symmetric(vertical: 10.0.h),
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/drop.svg",
                                                                                                                  height: 40.h,

                                                                                                            ),),
                                                                                                ],
                                                                                          ),
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .topCenter,
                                                                                                            child: Text(
                                                                                                                "1.0 mm"),),
                                                                                                ],
                                                                                          ),
                                                                                    ]
                                                                                ),
                                                                          ),
                                                                          Container(
                                                                            height: 170.0.h,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .end,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                        margin: EdgeInsets.symmetric(vertical: 10.0.h),
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/compass.svg",
                                                                                                                  height: 40.h,

                                                                                                            ),),
                                                                                                ],
                                                                                          ),
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            child: Text(
                                                                                                                "${state.loadedWeather.windDirection()}"),),
                                                                                                ],
                                                                                          ),
                                                                                    ]),
                                                                          ),
                                                                          Container(
                                                                            height: 170.0.h,
                                                                                alignment: Alignment
                                                                                    .topCenter,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                        margin: EdgeInsets.symmetric(vertical: 10.0.h),
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/degree-celsius.svg",
                                                                                                                  height: 40.h,

                                                                                                            ),),
                                                                                                ],
                                                                                          ),
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            child: Text(
                                                                                                                "${state.loadedWeather.pressure} hPa"),),
                                                                                                ],
                                                                                          ),
                                                                                    ]
                                                                                ),
                                                                          ),
                                                                    ],
                                                              ),
                                                        ),
                                                        Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                    const SizedBox(
                                                                        height: 30),
                                                                    TextButton(
                                                                          style: TextButton
                                                                              .styleFrom(
                                                                                textStyle: const TextStyle(
                                                                                    fontSize: 30),
                                                                          ),
                                                                          onPressed: () {Share.share("Hello! Weather on ${state.loadedWeather.date.day}.${state.loadedWeather.date.month}.${state.loadedWeather.date.year}:\n\n"
                                                                              "Location: ${state.loadedWeather.city}, ${state.loadedWeather.country}\nWeather: ${state.loadedWeather.getEmojiWeather()} ${state.loadedWeather.temp}°C ${state.loadedWeather.weather}\n"
                                                                              "\nOther parameters:\nHumidity: ${state.loadedWeather.humidity}%\nWind: ${state.loadedWeather.windSpeed} km/h ${state.loadedWeather.windDirection()}\n"
                                                                              "Pressure: ${state.loadedWeather.pressure} hPa");},
                                                                          child: const Text(
                                                                              'Weather Today Share', style: TextStyle(color: Colors.white)),
                                                                    ),
                                                              ],
                                                        ),
                                                  ],
                                            )
                                        ),
                                  ),
                            ],
                      ),
                ),
          );
          }
          return Center(
            child: ScreenUtilInit(
              designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              minTextAdapt: true,
              builder: () => RefreshIndicator(
                onRefresh: () async {
                  weatherBloc.add(WeatherRefreshEvent());
                },
                child: Stack(
                    children: <Widget>[
                      ListView(),
                      Center(
                        child: Text("Hello! No data! :(("),
                      ),
                    ]
                ),
              ),
            ),
          );
        }
    );
  }
}


