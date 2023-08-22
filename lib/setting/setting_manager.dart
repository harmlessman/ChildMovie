
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


/// app의 setting 값들을 관리하는 class
class SettingManager with ChangeNotifier {
  static late SharedPreferences prefs;

  late bool block18; //청소년관람불가 영화 차단 여부

  /// SharedPreferences instance 생성
  /// 앱 시작시 실행
  static Future<void> getSharedPreferencesInstance() async {
    prefs = await SharedPreferences.getInstance();

  }

  /// 앱 최초 실행 시 초기 값 세팅 (SharedPreferences)
  /// 앱 최초 실행이 아닌 경우는 동작하지 않음
  static Future<void> setInitialValues() async {
    if (prefs.getBool('firstRun') == null){

      // app_config 가져옴
      String jsonString = await rootBundle.loadString('assets/app_config.json');

      Map<String, dynamic> jsonData = json.decode(jsonString);

      prefs.setBool('firstRun', true);
      prefs.setBool('block18', true);

      // app_config 에서 가져오는 값
      prefs.setString('version', jsonData['version']);
      prefs.setString('initialDataDate', jsonData['initialDataDate']);

      // initialDataDate의 값을 초깃값으로 가져옴
      // 업데이트를 통해 값 변경됨
      prefs.setInt('updatedYear', int.parse(jsonData['initialDataDate'].split('-')[0]));
      prefs.setInt('updatedMonth', int.parse(jsonData['initialDataDate'].split('-')[1]));


    }

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
