import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class UpdateLoadingPage extends StatefulWidget {
  const UpdateLoadingPage({super.key});

  @override
  State<UpdateLoadingPage> createState() => _UpdateLoadingPage();
}

class _UpdateLoadingPage extends State<UpdateLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie_files/download.json'),
              SizedBox(height: 100.h,),
              Text(
                "다운로드중...\n잠시만 기다려주세요",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 50.0.sp,
                  fontWeight: FontWeight.bold,
                    height:1.5.h
                ),
                  textAlign:TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
