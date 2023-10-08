import 'dart:io';

import 'package:child_movie/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:child_movie/setting/setting_manager.dart';
import 'pages/detail_search_page.dart';
import 'pages/search_page.dart';
import 'pages/movie_rating_info.dart';
import 'pages/update_page.dart';
import 'package:child_movie/google_admob/google_admob.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 세로화면 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //인트로 시작
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // SettingManager에 SharedPreferences instance 미리 생성
  await SettingManager.getSharedPreferencesInstance();
  //SettingManager.prefs.clear();
  // 앱 최초 실행 시 초기 값 세팅 (SharedPreferences)
  await SettingManager.setInitialValues();

  // 앱 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 모바일 광고 sdk 초기화
  MobileAds.instance.initialize();

  // 광고 id setting
  await AdMob.setAdUnitId();

  // 앱 시작
  runApp(const MyApp());

  sleep(const Duration(seconds: 1)); //인트로 최소 유지시간 보장
  FlutterNativeSplash.remove(); //인트로 종료
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 첫 실행이면 onboarding 페이지로 이동하고, firstRun 값을 false로 변경
  String getInitialRoute(){
    if (SettingManager.prefs.getBool('firstRun')!){
      SettingManager.prefs.setBool('firstRun', false);
      return '/onboarding';
    }
    return '/';
  }

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
                initialRoute: getInitialRoute(),
                routes: {
                  '/': (context) => HomePage(),
                  '/search': (context) => SearchPage(),
                  '/detail_search': (context) => DetailSearchPage(),
                  '/rating_info': (context) => MovieRatingInfoPage(),
                  '/update': (context) => UpdatePage(),
                  '/onboarding' : (context) => OnboardingPage(),
                });
          }),
    );
  }
}
