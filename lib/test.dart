import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'first_run_screen.dart';
import 'ticket_booking.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import 'package:child_movie/db/movie_database.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  MovieDatabase db = MovieDatabase();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Home Page'),
      ),
      body: new Center(
        child:Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print(db.openDB());
              },
              child: const Text('Open DB', style: TextStyle(fontSize: 50))
            ),
            ElevatedButton(
              onPressed: () {
                db.openDBFromJson();
              },
              child: const Text('Open DB From Json', style: TextStyle(fontSize: 50)),
            ),
            ElevatedButton(
              onPressed: () {
                db.p();
              },
              child: const Text('Print', style: TextStyle(fontSize: 50)),
            ),
            ElevatedButton(
              onPressed: () {
                db.delete();
              },
              child: const Text('delete', style: TextStyle(fontSize: 50)),
            ),
            ElevatedButton(
              onPressed: () {
                db.test();
              },
              child: const Text('test', style: TextStyle(fontSize: 50)),
            ),
          ],
        ),
      ),
    );
  }

  void myFunction() {
    // Do something.
    print('Hello, world!');
  }

  void main2() async {
    // Read the JSON file
    String jsonString = await rootBundle.loadString('assets/movie.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    int i = 0;

    print(jsonData['movie_db'].keys.toList()[0]);
//     for (var movie in jsonData['movie_db']) {
//       if (i < 100) {
//         print(movie);
//         i++;
//       }
//     }
  }


}

