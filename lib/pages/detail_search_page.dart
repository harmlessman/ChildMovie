import 'package:flutter/material.dart';

class DetailSearchPage extends StatefulWidget {
  const DetailSearchPage({super.key});

  @override
  State<DetailSearchPage> createState() => _DetailSearchPageState();
}

class _DetailSearchPageState extends State<DetailSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8b89b),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Text('Detail Search Page\n개발 중입니다.',
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
