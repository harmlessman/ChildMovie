import 'package:flutter/material.dart';
import 'package:child_movie/db/movie.dart';
import 'package:child_movie/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieInfoPage extends StatefulWidget {
  final Movie movie;

  const MovieInfoPage({required this.movie, Key? key}) : super(key: key);

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: getRatingImage(widget.movie.gradeName,
                          width: 200.w, height: 200.h)),
                  SizedBox(
                    width: 40.w,
                  ),
                  Container(
                    width: size.width - 224.w,
                    height: 220.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.movie.useTitle!,
                          style: TextStyle(fontSize: 32.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          widget.movie.oriTitle!,
                          style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: getCoreHarmImageList(
                              widget.movie.coreHarmRsn,
                              widget.movie.rtCoreHarmRsnNm,
                              width: 50.w,
                              height: 50.h),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "줄거리",
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                widget.movie.workCont!,
                style: TextStyle(color: Colors.grey, fontSize: 16.sp),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "서술적 묘사",
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                widget.movie.descriptive_content!,
                style: TextStyle(color: Colors.grey, fontSize: 16.sp),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                "영화 등급분류",
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(
                height: 50.h,
              ),
              AspectRatio(
                aspectRatio: 1.2,
                child: RadarChart(
                  RadarChartData(
                    // 레이더 바깥 선
                    radarBorderData: BorderSide(
                        color: Colors.black.withOpacity(0.5), width: 2),
                    //radarShape: RadarShape.circle,
                    dataSets: [
                      RadarDataSet(
                        fillColor: ratingToColor(widget.movie.gradeName!)
                            .withOpacity(0.8),
                        borderColor: ratingToColor(widget.movie.gradeName!)
                            .withOpacity(0.8),
                        borderWidth: 2,
                        entryRadius: 1,
                        dataEntries: [
                          RadarEntry(
                              value: ratingToInt(widget.movie.rtStdName1!)
                                  .toDouble()),
                          RadarEntry(
                              value: ratingToInt(widget.movie.rtStdName2!)
                                  .toDouble()),
                          RadarEntry(
                              value: ratingToInt(widget.movie.rtStdName3!)
                                  .toDouble()),
                          RadarEntry(
                              value: ratingToInt(widget.movie.rtStdName4!)
                                  .toDouble()),
                          RadarEntry(
                              value: ratingToInt(widget.movie.rtStdName5!)
                                  .toDouble()),
                          RadarEntry(
                              value: ratingToInt(widget.movie.rtStdName6!)
                                  .toDouble()),
                          RadarEntry(
                              value: ratingToInt(widget.movie.rtStdName7!)
                                  .toDouble()),
                        ],
                      ),

                      // 최댓값 5 보장
                      RadarDataSet(
                        fillColor: Colors.white.withOpacity(0),
                        borderColor: Colors.white.withOpacity(0),
                        borderWidth: 2,
                        entryRadius: 1,
                        dataEntries: [
                          RadarEntry(value: 5),
                          RadarEntry(value: 5),
                          RadarEntry(value: 5),
                          RadarEntry(value: 5),
                          RadarEntry(value: 5),
                          RadarEntry(value: 5),
                          RadarEntry(value: 5),
                        ],
                      ),
                    ],
                    radarBackgroundColor: Colors.transparent,
                    borderData: FlBorderData(show: false),
                    //radarBorderData: const BorderSide(color: Colors.transparent),
                    titlePositionPercentageOffset: 0.2,
                    titleTextStyle: TextStyle(fontSize: 14.sp),

                    ///////////////// 이름
                    getTitle: (index, angle) {
                      final usedAngle = angle;
                      switch (index) {
                        case 0:
                          return RadarChartTitle(
                            text: '주제 및 내용',
                            angle: usedAngle,
                          );
                        case 1:
                          return RadarChartTitle(
                            text: '선정성',
                            angle: usedAngle,
                          );
                        case 2:
                          return RadarChartTitle(
                            text: '폭력성',
                            angle: usedAngle,
                          );
                        case 3:
                          return RadarChartTitle(
                            text: '공포',
                            angle: usedAngle,
                          );
                        case 4:
                          return RadarChartTitle(
                            text: '약물',
                            angle: usedAngle,
                          );
                        case 5:
                          return RadarChartTitle(
                            text: '대사',
                            angle: usedAngle,
                          );
                        case 6:
                          return RadarChartTitle(
                            text: '모방위험',
                            angle: usedAngle,
                          );
                        default:
                          return const RadarChartTitle(text: '');
                      }
                    },
                    ///////////////////////

                    tickCount: 1,
                    ticksTextStyle:
                        TextStyle(color: Colors.transparent, fontSize: 10.sp),
                    // 안에들어있는 최솟값 선
                    tickBorderData: const BorderSide(color: Colors.transparent),

                    // 중심에서 각으로 뻗는 선
                    gridBorderData: BorderSide(
                        color: Colors.transparent.withOpacity(0.2), width: 2.w),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 400),
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              Text(
                "기타 영화 정보",
                style: TextStyle(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '제작 연도 : ${widget.movie.prodYear}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '제작 국가 : ${widget.movie.direNatnlName}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '제작자 : ${widget.movie.prodcName}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '상영 시간 : ${widget.movie.screTime}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '영화의 종류 : ${widget.movie.mvAssoName}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '감독 : ${widget.movie.direName}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '주연 : ${widget.movie.leadaName}',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '관람 등급 : ${widget.movie.gradeName}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '주제 : ${widget.movie.rtStdName1}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '선정성 : ${widget.movie.rtStdName2}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '폭력성 : ${widget.movie.rtStdName3}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '공포 : ${widget.movie.rtStdName4}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '약물 : ${widget.movie.rtStdName5}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '대사 : ${widget.movie.rtStdName6}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '모방위험 : ${widget.movie.rtStdName7}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        '등급분류번호 : ${widget.movie.rtNo}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
