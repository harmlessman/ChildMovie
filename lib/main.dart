import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'first_run_screen.dart';
import 'pages/home_page.dart';

import 'pages/detail_search_page.dart';
import 'pages/search_page.dart';
import 'pages/movie_rating_info.dart';
import 'pages/update_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('is_first_run') == null) {
    prefs.setBool('is_first_run', true);
    runApp(const MaterialApp(
      home: FirstRunScreen(),
    ));
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '아이의 영화',
        debugShowCheckedModeBanner: false,
        initialRoute:'/',
        routes: {
          '/': (context) => HomePage(),
          '/search': (context) => SearchPage(),
          '/detail_search': (context) => DetailSearchPage(),
          '/rating_info': (context) => MovieRatingInfoPage(),
          '/update': (context) => UpdatePage(),
        }
        );
  }
}


