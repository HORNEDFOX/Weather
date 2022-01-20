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
              return Scaffold(
                backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 1.0,
                  backgroundColor: const Color.fromRGBO(74, 153, 230, 0.8),
                  title: Text("Forecast"),
                ),
                body: Center(
                  child: Text(
                    'No data received',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              );
            }

            if (state is WeatherLoadingState) {
              return Scaffold(
                  backgroundColor: const Color.fromRGBO(113, 128, 154, 0.1),
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 1.0,
                    backgroundColor: const Color.fromRGBO(74, 153, 230, 0.8),
                    title: Text("Forecast"),
                  ),
                body: Center(
                child: Text(
                  'No data received. Press button "Load"',
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
                  backgroundColor:const Color.fromRGBO(250, 250, 250, 1),
                  title: Text("${state.loadedWeather.city}", style: TextStyle(color: const Color.fromRGBO(40, 40, 40, 0.8),)),
                ),
                body: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: state.loadedWeather.temp <= 15 ? [
            const Color.fromRGBO(167, 112, 239, 1),
            const Color.fromRGBO(207, 139, 243, 1),
            const Color.fromRGBO(253, 185, 155, 1),
            ] : [
            const Color.fromRGBO(255, 95, 109, 1),
            const Color.fromRGBO(255, 195, 113, 1),
            ],
            ),
            ),
                  child: GroupedListView<dynamic, DateTime>(
                    elements: state.loadedForecast,
                    groupBy: (item) => DateTime(
                      item.date.year,
                      item.date.month,
                      item.date.day,
                    ),
                    groupSeparatorBuilder: (item) => Padding(padding: EdgeInsets.all(10),child: Text(item.weekday == DateTime.now().weekday ? 'Today' : '${DateFormat('EEEE').format(item)} ', style: TextStyle(fontSize: 25.0, color: Colors.white),)),
                    itemBuilder: (context, item){
                    return ForecastCard(icon: '${item.getIconWeather()}', weather: '${item.weather}', temp: item.temp, time:  '${item.date.hour}:${item.date.minute}0');
                    },
                ),
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
  late final int temp;
  late final String time;
  late final String icon;

  ForecastCard({required this.weather, required this.temp, required this.time, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    builder: () => Center(
        child: Card(
          margin: EdgeInsets.fromLTRB(10,5,10,5),
      elevation: 0.0,
      color: temp <= 15 ? Color.fromRGBO(100, 80, 180, 0.3) : Color.fromRGBO(200, 95, 109, 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15.0, right: 20.0),
                height: 70.0,
                width: 70.0,
              child: Center(child: SvgPicture.asset(
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
                Row(
                  children: [
                    Container(
                    height: 45,
                    width: 100.0,
                    alignment: Alignment.bottomLeft,
                    child: Text("${time}", style: TextStyle(fontSize: 23.sp, color: Colors.white),),
                    ),
      ]
                ),
                Row(
                    children: [
                      Container(
                        height: 35.0,
                        width: 100.0,
                        child: Text('${weather}', style: TextStyle(fontSize: 18.sp, color: Colors.white),),),
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
                  alignment: Alignment.centerRight,
                  height: 80.0,
                  width: 80.0,
                  child: Text("${temp}°", style: TextStyle(fontSize: 45.sp, color: Colors.white),),),
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

