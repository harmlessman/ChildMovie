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
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Center(
        child: Text('Detail Search Page',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
            )
        ),
      ),
    );
  }

}
