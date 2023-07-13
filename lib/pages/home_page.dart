import 'package:flutter/material.dart';
import 'package:child_movie/setting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List options = [
    {
      'name': '검색',
      'icon': Icon(
        Icons.search,
        size: 70.0.h,
        color: Colors.white,
      ),
      'key': 'search',
    },
    {
      'name': '상세 검색\n(개발 중)',
      'icon': Icon(
        Icons.content_paste_search,
        size: 70.0.h,
        color: Colors.white,
      ),
      'key': 'detail_search',
    },
    {
      'name': '영상 등급 정보\n(개발 중)',
      'icon': Icon(
        Icons.movie_filter,
        size: 70.0.h,
        color: Colors.white,
      ),
      'key': 'rating_info',
    },
    {
      'name': '업데이트\n(개발 중)',
      'icon': Icon(
        Icons.update,
        size: 70.0.h,
        color: Colors.white,
      ),
      'key': 'update',
    },
  ];

  Color _color = Colors.green;

  Widget optionBox(Map<String, dynamic> option) {
    return GestureDetector(
      onTap: () {
        setState(() {});
        Navigator.pushNamed(context, '/${option['key']}');
      },
      child: Container(
        // width: 40,
        // height: 40,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            option['icon'],
            SizedBox(
              height: 10.0.h,
            ),
            Text(
              option['name']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  //fontFamily: 'normal',
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0.sp,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double heightFromWhiteBg = 1000.h - kToolbarHeight;
    return Container(
      height: size.height - kToolbarHeight,
      color: Color(0xffFEEBB6),
      child: Stack(
        children: [
          Positioned(
            top: 50.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              color: Color(0xffFEEBB6),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Setting(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.settings,
                        size: 40.0.h,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Text(
                    "안녕하세요 사용자님",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xff2f5d62).withOpacity(0.77),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Text(
                    "사용하실 기능을\n선택해주세요",
                    style: TextStyle(
                      //fontFamily: 'normal',
                      decoration: TextDecoration.none,
                      color: Color(0xff2f5d62),
                      fontSize: 40.0.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 300.0.h,
            width: size.width,
            child: Container(
              height: heightFromWhiteBg,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
            ),
          ),
          Positioned(
              top: 300.0.h,
              height: heightFromWhiteBg,
              width: size.width,
              child: GridView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.0.h, vertical: 24.0.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2.h,
                    crossAxisSpacing: 24.0.h,
                    mainAxisSpacing: 24.0.h,
                  ),
                  children: <Widget>[
                    optionBox(options[0]),
                    optionBox(options[1]),
                    optionBox(options[2]),
                    optionBox(options[3]),
                  ])),
          Positioned(
              bottom: 24.h,
              left: 195.w,
              child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/age_rating/sum.png',
                  width: 150.w,
                  height: 150.h,
                ),
              ))
        ],
      ),
    );
  }
}
