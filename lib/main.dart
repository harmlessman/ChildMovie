import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'package:child_movie/setting/setting_manager.dart';
import 'pages/detail_search_page.dart';
import 'pages/search_page.dart';
import 'pages/movie_rating_info.dart';
import 'pages/update_page.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 세로화면 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //인트로 시작
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // SettingManager에 SharedPreferences instance 미리 생성
  await SettingManager.getSharedPreferencesInstance();

  // 앱 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 앱 시작
  runApp(const MyApp());

  sleep(const Duration(seconds: 1)); //인트로 최소 유지시간 보장
  FlutterNativeSplash.remove(); //인트로 종료
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingManager()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(540.0, 1152.0),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
                title: '아이의 영화',
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.black),
                    ),
                  fontFamily: 'maple',
                ),
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                routes: {
                  '/': (context) => HomePage(),
                  '/search': (context) => SearchPage(),
                  '/detail_search': (context) => DetailSearchPage(),
                  '/rating_info': (context) => MovieRatingInfoPage(),
                  '/update': (context) => UpdatePage(),
                });
          }),
    );
  }
}
