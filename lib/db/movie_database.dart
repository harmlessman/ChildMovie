import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import 'package:child_movie/db/movie.dart';


// ['aplcName', 'coreHarmRsn', 'descriptive_content', 'direName', 'direNatnlName', 'gradeName', 'leadaName', 'mvAssoName', 'oriTitle', 'prodYear', 'prodcName', 'prodcNatnlName', 'rtDate', 'rtNo', 'rtStdName1', 'rtStdName2', 'rtStdName3', 'rtStdName4', 'rtStdName5', 'rtStdName6', 'rtStdName7', 'screTime', 'stadCont', 'suppaName', 'useTitle', 'workCont', 'rtCoreHarmRsnNm']
// 27개

const String DB_FILE_NAME = 'movies.db';
const String TABLE_NAME = 'movies';
const String CREATE_TABLE_QUERY = '''
      CREATE TABLE IF NOT EXISTS $TABLE_NAME (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      aplcName TEXT,
      coreHarmRsn TEXT,
      descriptive_content TEXT,
      direName TEXT,
      direNatnlName TEXT,
      gradeName TEXT,
      leadaName TEXT,
      mvAssoName TEXT,
      oriTitle TEXT,
      prodYear TEXT,
      prodcName TEXT,
      prodcNatnlName TEXT,
      rtCoreHarmRsnNm TEXT,
      rtDate TEXT,
      rtNo TEXT,
      rtStdName1 TEXT,
      rtStdName2 TEXT,
      rtStdName3 TEXT,
      rtStdName4 TEXT,
      rtStdName5 TEXT,
      rtStdName6 TEXT,
      rtStdName7 TEXT,
      screTime TEXT,
      stadCont TEXT,
      suppaName TEXT,
      useTitle TEXT,
      workCont TEXT
      )
    ''';


class MovieDatabase{
  late Database db;


  Future openDB() async{
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, DB_FILE_NAME);
    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating $DB_FILE_NAME from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", DB_FILE_NAME));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      print('Created!');
    }

    db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: (Database db, int version) => {},
      onUpgrade: _onUpgrade,
    );

    print('Opened!');

  }



  // Future _onCreate(Database db, int version) async {
  //
  //   await db.execute(CREATE_TABLE_QUERY);
  //
  //   final databasePath = await getDatabasesPath();
  //   String path = join(databasePath, DB_FILE_NAME);
  //
  //   var exists = await databaseExists(path);
  //
  //   if (!exists) {
  //     print("Creating $DB_FILE_NAME from asset");
  //     try {
  //       await Directory(dirname(path)).create(recursive: true);
  //     } catch (_) {}
  //   }
  //
  //   ByteData data = await rootBundle.load(join("assets", DB_FILE_NAME));
  //   List<int> bytes =
  //   data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //   await File(path).writeAsBytes(bytes, flush: true);
  //
  //   print('create done');
  // }
  //
  // Future _onCreateFromJson(Database db, int version) async {
  //   await db.execute(CREATE_TABLE_QUERY);
  //
  //   String jsonString = await rootBundle.loadString('assets/movies.json');
  //
  //   Map<String, dynamic> jsonData = json.decode(jsonString);
  //
  //   jsonData.keys.toList().forEach((key) async {
  //     await db.insert(TABLE_NAME, jsonData[key],conflictAlgorithm: ConflictAlgorithm.replace,);
  //   });
  // }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 나중에 만들거임
  }

  Future<Movie> insertMovie(Movie movie) async{
    await db.insert(TABLE_NAME, movie.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,);

    return movie;
  }

  Future<List<Movie>> getMovieFromTitle(String word) async{
    List<Movie> searchResult = [];

    // List<Map<String, dynamic>> maps = await db.query(
    //   TABLE_NAME,
    //   columns: ['id', 'aplcName', 'coreHarmRsn', 'descriptive_content', 'direName', 'direNatnlName', 'gradeName', 'leadaName', 'mvAssoName', 'oriTitle', 'prodYear', 'prodcName', 'prodcNatnlName', 'rtDate', 'rtNo', 'rtStdName1', 'rtStdName2', 'rtStdName3', 'rtStdName4', 'rtStdName5', 'rtStdName6', 'rtStdName7', 'screTime', 'stadCont', 'suppaName', 'useTitle', 'workCont', 'rtCoreHarmRsnNm'],
    //   where: 'oriTitle LIKE ? OR useTitle LIKE ?',
    //   whereArgs: ['%$word%'],
    // );
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM $TABLE_NAME WHERE oriTitle LIKE \'%$word%\' OR useTitle LIKE \'%$word%\'');

    for (int i = 0; i < maps.length; i++) {
      searchResult.add(Movie.fromJson(maps[i]));
    }

    print(maps.length);

    return searchResult;
  }


  Future deleteDB() async{
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, DB_FILE_NAME);
    await databaseFactory.deleteDatabase(path);
    print('done');
  }

}







