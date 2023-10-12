import 'package:child_movie/setting/setting_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:child_movie/setting/setting_pages/app_info_page.dart';
import 'package:provider/provider.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    SettingManager settingManager = Provider.of<SettingManager>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '설정',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text('기본 설정'),
          ),
          ListTile(
            title: Text('청소년관람불가 영화 차단'),
            subtitle: Text('청소년관람불가인 영화를 검색결과로 나타내지 않습니다'),
            trailing: CupertinoSwitch(
              activeColor: Colors.red,
              value: settingManager.getBlock18,
              onChanged: (value) {
                setState(() {
                  settingManager.setBlock18 = value;
                });
              },
            ),
          ),
          ListTile(
              title: Text('튜토리얼 다시보기'),
              subtitle: Text('앱 처음 실행 시 나오는 설명 페이지를 엽니다'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/onboarding', (route) => false);
              }),
          Container(
            color: Colors.grey.withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text('정보'),
          ),
          ListTile(
              title: Text('앱 정보'),
              subtitle: Text('버전, 제작자, 영화데이터 등의 정보'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AppInfoPage()),
                );
              }),
          ListTile(
              title: Text('오픈소스 라이선스 정보'),
              subtitle: Text('라이브러리, 아이콘, 이미지 등의 라이선스 정보'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LicensePage()),
                );
              }),
        ],
      ),
    );
  }
}
