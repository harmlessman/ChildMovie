import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/home_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'pages/detail_search_page.dart';
import 'pages/search_page.dart';
import 'pages/movie_rating_info.dart';
import 'pages/update_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); //인트로 시작

  //SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
  // if (prefs.getBool('is_first_run') == null) {
  //   prefs.setBool('is_first_run', true);
  //   runApp(MyApp());
  // } else {
  //   runApp(MyApp());
  // }
  sleep(const Duration(seconds: 1)); //인트로 최소 유지시간 보장
  FlutterNativeSplash.remove(); //인트로 종료
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(540.0, 1152.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: '아이의 영화',
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (context) => HomePage(),
                '/search': (context) => SearchPage(),
                '/detail_search': (context) => DetailSearchPage(),
                '/rating_info': (context) => MovieRatingInfoPage(),
                '/update': (context) => UpdatePage(),
              });
        });
  }
}
