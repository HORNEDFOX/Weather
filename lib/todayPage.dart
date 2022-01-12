import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: Center(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset(
                        "assets/image/sunny.svg",
                      width: MediaQuery.of(context).size.width-200,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text('City', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)
                    ),
              ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text("22 Sunny", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
      ),
    );
  }
}
