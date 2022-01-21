import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatelessWidget {

  late String header;
  late String texts;

  EmptyState(header, texts)
  {
    this.texts = texts;
    this.header = header;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    height: MediaQuery
        .of(context)
        .size
        .height,
    width: MediaQuery
        .of(context)
        .size
        .width,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/image/error.png"),
    fit: BoxFit.fitWidth,
    ),
    ),
    child:Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    Text(header, style: TextStyle(fontSize: 30.0.sp, color: const Color.fromRGBO(96, 99, 154, 1), fontWeight: FontWeight.w700, letterSpacing: 1),
),
SizedBox(height: 20.sp,),
Container(
width: 300.sp,
child: Text(texts, textAlign: TextAlign.center,
style: TextStyle(fontSize: 20.0.sp),
),
),
SizedBox(height: 150.sp,),
],
),
);
  }
}


List<Color> colorBackground(temp)
{
  if(temp < -15)
  {
    return [
      const Color.fromRGBO(255, 95, 109, 1),
      const Color.fromRGBO(255, 195, 113, 1),
    ];
  }
  else if(temp >= -15 && temp <= 15)
  {
    return [const Color.fromRGBO(167, 112, 239, 1),
      const Color.fromRGBO(207, 139, 243, 1),
      const Color.fromRGBO(253, 185, 155, 1),];
  }
  else if(temp >= 16 && temp <= 20)
  {
    return [
      const Color.fromRGBO(0, 176, 155, 1),
      const Color.fromRGBO(150, 201, 61, 1),];
  }else if(temp >= 21)
  {
    return [
      const Color.fromRGBO(255, 95, 109, 1),
      const Color.fromRGBO(255, 195, 113, 1),];
  }

  return [
    const Color.fromRGBO(97, 97, 97, 1),
    const Color.fromRGBO(155, 197, 195, 1),
  ];
}