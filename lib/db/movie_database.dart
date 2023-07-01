import 'dart:convert';

import 'dart:io';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';


// ['aplcName', 'coreHarmRsn', 'descriptive_content', 'direName', 'direNatnlName', 'gradeName', 'leadaName', 'mvAssoName', 'oriTitle', 'prodYear', 'prodcName', 'prodcNatnlName', 'rtDate', 'rtNo', 'rtStdName1', 'rtStdName2', 'rtStdName3', 'rtStdName4', 'rtStdName5', 'rtStdName6', 'rtStdName7', 'screTime', 'stadCont', 'suppaName', 'useTitle', 'workCont', 'rtCoreHarmRsnNm']
// 27개


const String CREATE_TABLE_QUERY = '''
      CREATE TABLE IF NOT EXISTS movies2 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      direName TEXT,
      coreHarmRsn TEXT,
      descriptive_content TEXT,
      prodcNatnlName TEXT,
      useTitle TEXT,
      suppaName TEXT,
      prodcName TEXT,
      direNatnlName TEXT,
      rtNo TEXT,
      rtDate TEXT,
      screTime TEXT,
      rtStdName4 TEXT,
      rtStdName5 TEXT,
      gradeName TEXT,
      rtStdName6 TEXT,
      leadaName TEXT,
      rtStdName7 TEXT,
      mvAssoName TEXT,
      workCont TEXT,
      prodYear TEXT,
      rtStdName1 TEXT,
      rtStdName2 TEXT,
      rtStdName3 TEXT,
      oriTitle TEXT,
      stadCont TEXT,
      aplcName TEXT,
      rtCoreHarmRsnNm TEXT
      )
    ''';

class MovieDatabase{

  Future p() async{
    final databasePath = await getDatabasesPath();
    print( databasePath );
  }
  Future openDB() async{
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'movie_db.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future openDBFromJson() async{
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'movie_db.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: _onCreateFromJson,
      onUpgrade: _onUpgrade,
    );

  }


  Future _onCreate(Database db, int version) async {
    await db.execute(CREATE_TABLE_QUERY);
  }

  Future _onCreateFromJson(Database db, int version) async {
    await db.execute(CREATE_TABLE_QUERY);
    print('b');
    String jsonString = await rootBundle.loadString('assets/movies.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    jsonData.keys.toList().forEach((key) async {
      print('a');
      await db.insert('movies2', jsonData[key],conflictAlgorithm: ConflictAlgorithm.replace,);
    });

  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  // 나중에 만들거임
  }

  Future add(item) async{
    final db = await openDB();

  }

  Future delete() async{
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'movie_db.db');
    databaseFactory.deleteDatabase(path);
    print('delete');
  }

  Future test() async{

  }

}







