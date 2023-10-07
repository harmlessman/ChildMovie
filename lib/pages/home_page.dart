import 'package:child_movie/google_admob/google_admob.dart';
import 'package:flutter/material.dart';
import 'package:child_movie/setting/setting_pages/setting_page.dart';
import 'package:flutter/services.dart';
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
  late Widget bannerAd;

  Widget optionBox(Map<String, dynamic> option, Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {});
        Navigator.pushNamed(context, '/${option['key']}');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:color,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
        elevation:10,

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
    );
  }

   exitDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AdMob.showExitAd(),
                SizedBox(height: 30.h,),
                Text(
                  '앱을 종료하시겠습니까?',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.h,
                        //width: 175.w,
                        child: OutlinedButton(
                          child: const Text('취소'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: SizedBox(
                        height: 60.h,
                        //width: 175.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Colors.blue),
                          child: const Text('종료'),
                          onPressed: () {
                            SystemNavigator.pop(animated: true);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 광고 load
    AdMob.loadExitAd(400.w.toInt(), 400.h.toInt());
    AdMob.loadRewardAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bannerAd = FutureBuilder(
        future: AdMob.loadBannerAd(context),
        builder: (context, snapshot){
          if (snapshot.hasData == false) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return AdMob.showBannerAd();
          }
        }

    );
  }

  @override
  Widget build(BuildContext context) {
    // 뒤로가기 버튼을 누르면 exitDialog() 실행
    return WillPopScope(
      onWillPop: () async{
        return exitDialog();
      },
      child: Container(
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
                        ])),
              ),
              bannerAd,

            ],
          ),
        ),
      ),
    );
  }
}
