import 'package:flutter/material.dart';
class FirstRunScreen extends StatefulWidget {
  const FirstRunScreen({Key? key}) : super(key: key);

  @override
  State<FirstRunScreen> createState() => _FirstRunScreenState();
}

class _FirstRunScreenState extends State<FirstRunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('First Run Screen'),
      ),
    );
  }
}
