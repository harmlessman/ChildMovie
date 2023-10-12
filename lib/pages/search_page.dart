import 'package:child_movie/setting/setting_manager.dart';
import 'package:flutter/material.dart';
import 'package:child_movie/db/movie_database.dart';
import 'package:child_movie/utils/preview_movies.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Widget> searchResult = [];

  // 검색창의 상태를 나타내는 숫자
  // -1 : 검색 중, 0 : 결과X, 자연수 : 결과O
  // 검색 중일 때를 제외하면 이 값은 검색된 데이터의 수와 일치함
  int resultState = 0;
  TextEditingController inputController = TextEditingController();

  late MovieDatabase db;

  @override
  void initState() {
    db = MovieDatabase();
    db.openDB();
    super.initState();
  }

  // 검색 결과 위젯


  @override
  Widget build(BuildContext context) {
    SettingManager settingManager = Provider.of<SettingManager>(context);
    Widget resultWidget(int state){
      switch (state){
      // 검색 중일 때
        case -1:
          return Lottie.asset('assets/lottie_files/search.json');
      // 결과가 없을 때
        case 0:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 100.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '검색 결과가 없습니다.',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
      // 결과가 있을 때
        default:
          // return ListView.builder(
          //     itemCount: searchResult.length,
          //     itemBuilder: (BuildContext context, int index){
          //       return Container(
          //         child: searchResult[index],
          //       );
          //     }
          // );
        return ListView(
          children: searchResult,
        );
      }
    }
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: 20.h, top: 40.h, right: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "검색 페이지 입니다",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black.withOpacity(0.77),
                fontSize: 20.0.sp,
                fontWeight: FontWeight.w600,
                height: 1.2.h,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "영화 제목을 입력하세요",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 35.0.h,
                fontWeight: FontWeight.w600,
                height: 1.2.h,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30.h),
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.h),
              height: 70.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: TextField(
                      onSubmitted: (v) async {
                        setState(() {
                          resultState = -1;
                        });

                        var data = await db.getMovieFromTitle(v, settingManager.getBlock18);

                        setState(() {
                          searchResult = makePreviewWidgets(data, context);
                          resultState = searchResult.length;
                        });
                      },
                      controller: inputController,
                      decoration: InputDecoration(
                        hintText: "Search for movie",
                        hintStyle: TextStyle(
                          color: Color(0xFFA0A5BD),
                          fontSize: 18.sp,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              "결과 개수 : ${searchResult.length}",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black.withOpacity(0.77),
                fontSize: 20.0.sp,
                fontWeight: FontWeight.w600,
                height: 1.2.h,
              ),
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: resultWidget(resultState)
            ),
          ],
        ),
      ),
    );
  }
}
