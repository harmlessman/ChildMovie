import 'package:flutter/material.dart';


import 'package:child_movie/setting/setting_manager.dart';


class AppInfoPage extends StatefulWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {

  @override
  Widget build(BuildContext context) {
    //SettingManager settingManager = Provider.of<SettingManager>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            '설정',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
                title: Text('앱 정보'),
                subtitle: Text('버전 : ${SettingManager.prefs.getString('version')}'),
                onTap: () {}),

            Divider(height: 0, thickness: 1),
            ListTile(
                title: Text('영화 데이터 정보'),
                subtitle: Text('초기 데이터 : ${SettingManager.prefs.getString('initialDataDate')}'),
                onTap: () {}),
            Divider(height: 0, thickness: 1),
            ListTile(
                title: Text('제작자 정보'),
                subtitle: Text('제작자 : harmlessman'),
                onTap: () {}),
            Divider(height: 0, thickness: 1),
          ],
        ));
  }
}
