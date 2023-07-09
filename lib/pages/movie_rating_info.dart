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
      appBar: AppBar(
        title: Text('Movie Rating Info'),
      ),
      body: Center(
        child: Text('Movie Rating Info Page',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
            )
        ),
      ),
    );
  }

}