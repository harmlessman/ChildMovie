import 'dart:async';

import 'package:child_movie/pages/update_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:child_movie/db/update.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  DateTime updateDate = getUpdateDate();
  late bool isLasted; // 최신 버전인지 아닌지
  Alignment align = Alignment.center; // db이미지 align
  Curve curve = Curves.bounceOut; // db이미지 curve
  late Timer timer; // image animation timer

  // 페이지 열 때 호출
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), (t) {
      setState(() {
        align =
        align == Alignment.center ? Alignment.topCenter : Alignment.center;
        curve = curve == Curves.bounceOut ? Curves.linear : Curves.bounceOut;
      });
    });
    super.initState();
  }

  // 닫을 때 호출
  @override
  void dispose() {
    timer.cancel(); // timer 해제
    super.dispose();
  }

  isInternetConnected() async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /// 업데이트 필요 없을 때 호출되는 dialog
    isLastedDialog() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.report_problem,
                    size: 70.0.h,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '영화 데이터가 이미 최신 버전입니다',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        fixedSize: Size(300.w, 40.h),
                        backgroundColor: Colors.blue),
                    child: const Text('닫기'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    /// 업데이트가 끝나면 호출되는 dialog
    doneDialog(int num) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.download_done_rounded,
                    size: 70.0.h,
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      '업데이트가 완료되었습니다.\n추가된 영화 데이터 : $num개',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        fixedSize: Size(300.w, 40.h),
                        backgroundColor: Colors.green),
                    child: const Text('닫기'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            // actions: <Widget>[
            //   ElevatedButton(
            //     //style: ,
            //     child: const Text('닫기'),
            //
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ],
          );
        },
      );
    }

    /// 인터넷 연결이 되어있지 않으면 호출되는 dialog
    internetConnectionErrorDialog() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.public_off,
                    size: 70.0.h,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      '인터넷이 연결되어 있지 않습니다\n인터넷 연결을 확인해주세요',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center

                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        fixedSize: Size(300.w, 40.h),
                        backgroundColor: Colors.blue),
                    child: const Text('닫기'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/age_rating_image/9.jpg',
            ),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent, //투명
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // db이미지
            FittedBox(
              child: SizedBox(
                width: 540.w,
                height: 450.h,
                child: AnimatedAlign(
                  alignment: align,
                  duration: Duration(seconds: 2),
                  curve: curve,
                  child: Image.asset(
                    'assets/age_rating_image/db.png',
                    width: 400.h,
                    height: 400.w,
                  ),
                ),
              ),
            ),

            // 현재 업데이트, 최신 업데이트를 가져와서 build
            // 최신상태여부, 업데이트날짜, 업데이트버튼
            FutureBuilder(
                future: getLastUpdatedDate(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Widget child;

                  if (snapshot.hasData == false) {
                    child = CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    child = CircularProgressIndicator();
                  } else {
                    isLasted =
                    updateDate.compareTo(snapshot.data) == 0 ? true : false;

                    child = Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 400.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              isLasted == true
                                  ? Colors.green.shade300
                                  : Colors.red.shade300,
                              Colors.white
                            ], stops: [
                              0.5,
                              1
                            ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: Offset(0, 5)),
                            ],
                          ),
                          // container안의 edge
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0.w, vertical: 24.0.h),

                          child: Text("최신 상태 : $isLasted",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 30.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 24.h,),
                        Container(
                          width: 400.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              isLasted == true
                                  ? Colors.green.shade300
                                  : Colors.red.shade300,
                              Colors.white
                            ], stops: [
                              0.5,
                              1
                            ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 5)),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0.w, vertical: 24.0.h),

                          child: Column(
                            children: [
                              Text(
                                "현재 업데이트 : ${snapshot.data.year}-${snapshot.data.month.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 30.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              Text(
                                "최신 업데이트 : ${updateDate.year}-${updateDate.month.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 30.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return child;
                }),
            SizedBox(height: 48.h,),
            SizedBox(
              height:75.h,
              width: 300.w,
              child: ElevatedButton(
                onPressed: () async {
                  // 현재 업데이트와 최신업데이트 날짜가 같으면 업데이트 할 필요가 없으므로
                  if (isLasted) {
                    isLastedDialog();
                  }
                  // 업데이트 진행
                  else {
                    if (!(await isInternetConnected())){
                      internetConnectionErrorDialog();
                    }
                    else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateLoadingPage()),
                      );
                      var downloadedDataNum = await updateMovieInfo();

                      Navigator.pop(context);
                      doneDialog(downloadedDataNum);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    //fixedSize: Size(300.w, 75.h),
                    backgroundColor: Colors.green),
                child: Text(
                  'Update',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 30.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
