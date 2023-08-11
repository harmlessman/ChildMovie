import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateLoadingPage extends StatefulWidget {
  const UpdateLoadingPage({super.key});

  @override
  State<UpdateLoadingPage> createState() => _UpdateLoadingPage();
}

class _UpdateLoadingPage extends State<UpdateLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/age_rating_image/down.gif',
                width: 400.h,
                height: 400.w,
              ),
              Text(
                "다운로드중\n잠시만 기다려주세요",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 50.0.sp,
                  fontWeight: FontWeight.bold,
                ),
                  textAlign:TextAlign.center,
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     child: Text('back')
              // )
            ],
          ),
        ));
  }
}
