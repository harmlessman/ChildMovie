import 'package:flutter/material.dart';
import 'package:child_movie/setting/setting_pages/setting_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List options = [
    {
      'name': '영화 검색',
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


  Widget optionBox(Map<String, dynamic> option, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {});
        Navigator.pushNamed(context, '/${option['key']}');
      },
      child: Container(
        // width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 7,
                blurRadius: 10,
                offset: Offset(0, 10)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            option['icon'],
            SizedBox(
              height: 20.0.h,
            ),
            Text(
              option['name'],
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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.green.shade100,
            Colors.yellow.shade100,
            Colors.orange.shade100,
            Colors.red.shade100,
            //Color(0xffFEEBB6),
            //Colors.white
          ], stops: [
            0.25,
            0.5,
            0.75,
            1
          ],


          ),

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            //iconTheme: const IconThemeData(color: Colors.red),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ),
                  );
                },
              )
            ]),
        body: Column(
          children: [
            SizedBox(
              height: 20.0.h,
            ),
            Text(
              "안녕하세요 사용자님!",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(0xff2f5d62).withOpacity(0.77),
                fontSize: 30.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Text(
              "사용하실 기능을 선택해주세요",
              style: TextStyle(
                //fontFamily: 'normal',
                decoration: TextDecoration.none,
                color: Color(0xff2f5d62),
                fontSize: 40.0.sp,
                fontWeight: FontWeight.bold,
                height: 1.2.h,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 540.h,
                        child: GridView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0.w, vertical: 24.0.h),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 24.0.h,
                              mainAxisSpacing: 24.0.h,
                            ),
                            children: <Widget>[
                              optionBox(options[0], Colors.green.shade300),
                              optionBox(options[1], Colors.yellow.shade300),
                              optionBox(options[2], Colors.orange.shade300),
                              optionBox(options[3], Colors.red.shade300),
                            ]),
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/age_rating_image/sum.png',
                            width: 150.w,
                            height: 150.h,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
