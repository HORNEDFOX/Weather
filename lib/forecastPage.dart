import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/weatherBloc.dart';
import 'package:weather/weatherState.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';


class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}


  class _ForecastPageState extends State<ForecastPage> {

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmptyState) {
              return Center(
                child: Text(
                  'No data received. Press button "Load"',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }

            if (state is WeatherLoadingState) {
              return Center(
                child: Text(
                  'No data received. Press button "Load"',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }

            if (state is WeatherLoadedState) {
              return Scaffold(
                backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 1.0,
                  backgroundColor: const Color.fromRGBO(74, 153, 230, 0.8),
                  title: Text("${state.loadedWeather.city}"),
                ),
                body: GroupedListView<dynamic, DateTime>(
                    elements: state.loadedForecast,
                    groupBy: (item) => DateTime(
                      item.date.year,
                      item.date.month,
                      item.date.day,
                    ),
                    groupSeparatorBuilder: (item) => Padding(padding: EdgeInsets.all(10),child: Text(item.weekday == DateTime.now().weekday ? 'Today' : '${DateFormat('EEEE').format(item)} ', style: TextStyle(fontSize: 25.0),)),
                    itemBuilder: (context, item){
                    return ForecastCard(weather: '${item.weather}', temp: '${item.temp}', time:  '${item.date.hour}:${item.date.minute}0');
                    },
                ),
              );
            }
            return Center();
          }
      );
    }
  }

class ForecastCard extends StatelessWidget {

  late final String weather;
  late final String temp;
  late final String time;

  ForecastCard({required this.weather, required this.temp, required this.time});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
    minTextAdapt: true,
    builder: () => Center(
        child: Card(
          margin: EdgeInsets.fromLTRB(0,3,0,3),
      elevation: 0.0,
      shadowColor: Color.fromRGBO(148, 161, 187, 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
    child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15.0, right: 20.0),
                height: 80.0,
                width: 80.0,
              child: SvgPicture.asset(
                "assets/image/sunny.svg",
              ),
          ),
            ],
          ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                    height: 45,
                    width: 100.0,
                    alignment: Alignment.bottomLeft,
                    child: Text("${time}", style: TextStyle(fontSize: 23.sp),),
                    ),
      ]
                ),
                Row(
                    children: [
                      Container(
                        height: 35.0,
                        width: 100.0,
                        child: Text('${weather}', style: TextStyle(fontSize: 18.sp),),),
                    ]
                )
              ],
            ),
      ],
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  alignment: Alignment.center,
                  height: 80.0,
                  width: 80.0,
                  child: Text("${temp}°", style: TextStyle(fontSize: 50.sp),),),
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

