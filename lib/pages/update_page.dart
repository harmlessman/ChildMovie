import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffa2f2ea),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Text('Update Page\n개발 중입니다.',
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
