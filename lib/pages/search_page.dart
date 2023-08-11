import 'package:flutter/material.dart';
import 'package:child_movie/db/movie_database.dart';
import 'package:child_movie/utils/preview_movies.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Widget> searchResult = [];
  TextEditingController inputController = TextEditingController();

  late MovieDatabase db;

  @override
  void initState() {
    db = MovieDatabase();
    db.openDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        var data = await db.getMovieFromTitle(v);

                        setState(() {
                          searchResult = makePreviewWidgets(data, context);
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
              child: (searchResult.length > 0)
                  ? ListView(
                      children: searchResult,
                    )
                  : Column(
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
                          child: Text(
                            '검색 결과가 없습니다.',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
