import 'package:flutter/material.dart';

class MovieRatingInfoPage extends StatefulWidget {
  const MovieRatingInfoPage({super.key});

  @override
  State<MovieRatingInfoPage> createState() => _MovieRatingInfoPageState();
}

class _MovieRatingInfoPageState extends State<MovieRatingInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc1f7c1),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Text('Movie Rating Info Page\n개발 중입니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'normal',
              fontSize: 50,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
