import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/weatherBloc.dart';
import 'package:weather/weatherEvent.dart';
import 'package:weather/weatherState.dart';

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
            backgroundColor: const Color.fromRGBO(74, 153, 230, 0.8),
            title: const Text("Today"),
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
                designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                minTextAdapt: true,
                builder: () => RefreshIndicator(
                            onRefresh: () async {
                              return weatherBloc.add(WeatherRefreshEvent());
                            },
                            child: Stack(
                                children: <Widget>[
                                      ListView(),
                                      Text("1"),
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
                            children: <Widget>[ListView(),
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
                                                                          child: SizedBox(
                                                                                width: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .width,
                                                                                child: SvgPicture
                                                                                    .asset(
                                                                                      "assets/image/sunny.svg",
                                                                                      width: 200
                                                                                          .w,
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
                                                                              10),
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
                                                                                        fontSize: 30
                                                                                            .sp),)
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
                                                                                          fontSize: 45
                                                                                              .sp),),
                                                                          ),
                                                                    ),
                                                              ],
                                                        ),
                                                        Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                  30, 30, 30,
                                                                  30),
                                                              child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                          Container(
                                                                                height: 150.0,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .topCenter,
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/sunny.svg",
                                                                                                                  height: 70
                                                                                                                      .h,
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
                                                                                height: 150.0,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .end,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .bottomCenter,
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/sunny.svg",
                                                                                                                  height: 70
                                                                                                                      .h,
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
                                                                                height: 150.0,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            alignment: Alignment
                                                                                                                .topCenter,
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/sunny.svg",
                                                                                                                  height: 70
                                                                                                                      .h,
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
                                                                                height: 150,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .end,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/sunny.svg",
                                                                                                                  height: 70
                                                                                                                      .h,
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
                                                                                height: 150.0,
                                                                                alignment: Alignment
                                                                                    .topCenter,
                                                                                child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                          Row(
                                                                                                children: [
                                                                                                      Container(
                                                                                                            child: SvgPicture
                                                                                                                .asset(
                                                                                                                  "assets/image/sunny.svg",
                                                                                                                  height: 70
                                                                                                                      .h,
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
                                                                          onPressed: () {},
                                                                          child: const Text(
                                                                              'Share'),
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

