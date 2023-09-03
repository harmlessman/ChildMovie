import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final images = [
    'assets/age_rating_image/m.json',
    'assets/age_rating_image/load.json',
    'assets/age_rating_image/loading.json',
    'assets/age_rating_image/m.json',
  ];
  final titles = [
    '',
    '',
    '',
    ''
  ];
  final descs = [
    '',
    '',
    '',
    ''
  ];

  final pageController = PageController();
  final selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 뒤로가기 버튼 막기
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            // 사진, 텍스트, 텍스트
            Expanded(
                child: PageView.builder(
              itemCount: images.length,
              controller: pageController,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 400.h,
                      width: 400.w,
                      child: Lottie.asset(images[index]),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Text(
                      titles[index],
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 30.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Text(
                      descs[index],
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
              onPageChanged: (value) {
                selectedIndex.value = value;
              },
            )),
            // 페이지 어느쪽인지 나타내는 점들
            ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, value, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.0.w, vertical: 24.0.h),
                  child: Wrap(
                    spacing: 10,
                    children: List.generate(images.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 16.h,
                        width: value == index ? 40.w : 16.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: value == index
                                ? Colors.blueGrey.shade900
                                : Colors.blueGrey),
                      );
                    }),
                  ),
                );
              },
            ),
            // 맨 밑의 버튼
            // 마지막 페이지이면 '시작하기' 버튼으로, HomePage로 이동
            // 마지막 페이지가 아니라면 왼쪽에는 'skip' 버튼, 오른쪽은 'next' 버튼
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 24.0.w, vertical: 24.0.h),
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, value, child) {
                  if (selectedIndex.value == images.length - 1) {
                    return SizedBox(
                      height: 60.h,
                      width: 420.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                            backgroundColor: Colors.green),
                        child: Text(
                          '시작하기',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 30.0.sp,
                            fontWeight: FontWeight.normal,
                        ),),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            pageController.jumpToPage(images.length - 1);
                          },
                          child: Text('skip')),
                      ElevatedButton(
                          onPressed: () {
                            pageController.animateToPage(selectedIndex.value + 1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                              ),
                          child: Text('next'))
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
