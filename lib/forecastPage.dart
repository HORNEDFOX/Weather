import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: ListView(
        children: <Widget> [
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
          ForecastCard(),
        ],
      ),
    );
  }
}

class ForecastCard extends StatelessWidget {
  const ForecastCard({Key? key}) : super(key: key);

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
                    child: Text("19:00", style: TextStyle(fontSize: 23.sp),),
                    ),
      ]
                ),
                Row(
                    children: [
                      Container(
                        height: 35.0,
                        width: 100.0,
                        child: Text("Weather", style: TextStyle(fontSize: 18.sp),),),
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
                  child: Text("22°", style: TextStyle(fontSize: 50.sp),),),
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

