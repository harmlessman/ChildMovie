import 'package:flutter/material.dart';

Widget getRatingImage(String? gradeName,
    {double width = 50, double height = 50}) {
  switch (gradeName) {
    case '전체관람가':
      return Image.asset(
        'assets/age_rating/all.png',
        width: width,
        height: height,
      );
    case '12세이상관람가':
      return Image.asset(
        'assets/age_rating/12.png',
        width: width,
        height: height,
      );
    case '15세이상관람가':
      return Image.asset(
        'assets/age_rating/15.png',
        width: width,
        height: height,
      );
    case '청소년관람불가':
      return Image.asset(
        'assets/age_rating/18.png',
        width: width,
        height: height,
      );
    case '제한관람가':
      return Image.asset(
        'assets/age_rating/w.png',
        width: width,
        height: height,
      );
    default:
      return Icon(Icons.error);
  }
}

List<Widget> getCoreHarmImageList(String? coreHarmRsn, String? rtCoreHarmRsnNm,
    {double width = 50, double height = 50}) {
  List<Widget> coreHarmImageList = [];
  List<String> splitted = [];

  if (rtCoreHarmRsnNm != null) {
    splitted = rtCoreHarmRsnNm.split(',');
  } else if (coreHarmRsn != null) {
    splitted = [coreHarmRsn];
  }

  for (var sp in splitted) {
    switch (sp) {
      case '주제':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/1. 주제.png',
          width: width,
          height: height,
        ));
      case '주제 및 내용':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/1. 주제.png',
          width: width,
          height: height,
        ));
      case '선정성':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/2. 선정성.png',
          width: width,
          height: height,
        ));
      case '폭력성':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/3. 폭력성.png',
          width: width,
          height: height,
        ));
      case '공포':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/4. 공포.png',
          width: width,
          height: height,
        ));
      case '약물':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/5. 약물.png',
          width: width,
          height: height,
        ));
      case '대사':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/6. 대사.png',
          width: width,
          height: height,
        ));
      case '모방위험':
        coreHarmImageList.add(Image.asset(
          'assets/contents_rating/7. 모방위험.png',
          width: width,
          height: height,
        ));
    }
  }
  return coreHarmImageList;
}

int ratingToInt(String rating) {
  switch (rating) {
    case '전체관람가':
      return 1;
    case '12세이상관람가':
      return 2;
    case '15세이상관람가':
      return 3;
    case '청소년관람불가':
      return 4;
    case '제한관람가':
      return 5;
    default:
      return 0;
  }
}

Color ratingToColor(String rating) {
  switch (rating) {
    case '전체관람가':
      return Colors.green;
    case '12세이상관람가':
      return Colors.yellow;
    case '15세이상관람가':
      return Colors.orange;
    case '청소년관람불가':
      return Colors.red;
    case '제한관람가':
      return Colors.grey;
    default:
      return Colors.white;
  }
}
