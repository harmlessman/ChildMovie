import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// app의 setting 값들을 관리하는 class
class SettingManager with ChangeNotifier {
  static late SharedPreferences prefs;

  late bool block18; //청소년관람불가 영화 차단 여부

  // SharedPreferences instance 생성
  // 앱 시작시 실행
  static Future<void> getSharedPreferencesInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  SettingManager() {
    block18 = prefs.getBool('block18')!;
  }

  bool get getBlock18 => block18;

  set setBlock18(bool value) {
    block18 = value;
    prefs.setBool('block18', block18);
    notifyListeners();
  }
}
