/// Firestore 업데이트는 달에 한번씩, 5일에
/// ex) 7/5에 6월달 데이터 추가

import 'package:child_movie/db/movie_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:child_movie/db/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 최근 업데이트 년/월을 가져옴
Future<DateTime> getLastUpdatedDate() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int? year = prefs.getInt('updatedYear');
  int? month = prefs.getInt('updatedMonth');

  return DateTime(year!, month!);
}

/// 업데이트 후 년/월을 저장
Future<void> setLastUpdatedDate(int year, int month) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('updatedYear', year);
  await prefs.setInt('updatedMonth', month);

  return;
}

/// Firebase의 가장 최근 업데이트 날짜를 계산
/// 매달 5일에 데이터가 추가되므로 5일기준으로 계산
DateTime getUpdateDate() {
  DateTime now = DateTime.now();
  DateTime updateDate = now.day > 5
      ? DateTime(now.year, now.month - 1)
      : DateTime(now.year, now.month - 2);
  return updateDate;
}

/// Firestore에서 영화 데이터들을 가져옴
///
/// DateTime 값을 인자로 받고, 년-월(ex 2023-07)에 해당하는 컬렉션에서 영화정보들을 가져옴
Future<List<Movie>> getMovieFromFirestore(
    FirebaseFirestore firestore, DateTime date) async {
  List<Movie> movies = [];

  final moviesRef = firestore
      .collection('${date.year}-${date.month.toString().padLeft(2, '0')}')
      .withConverter<Movie>(
        fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(), //do not use
      );

  await moviesRef.get().then((snapshot) {
    for (var doc in (snapshot.docs)) {
      movies.add(doc.data());
    }
  });
  return movies;
}

/// 영화정보들을 내부 db에 저장
Future<int> updateMovieInfo() async {
  List<Future<List<Movie>>> futures = [];
  int movieCount = 0;
  DateTime lastUpdatedDate = await getLastUpdatedDate(); // year, month

  DateTime updateDate = getUpdateDate();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // now.compareTo(future); // -1
  // now.compareTo(past); // 1
  // now.compareTo(now); // 0

  while (true) {
    lastUpdatedDate = DateTime(lastUpdatedDate.year, lastUpdatedDate.month + 1);
    if (updateDate.compareTo(lastUpdatedDate) < 0) {
      break;
    }
    futures.add(getMovieFromFirestore(firestore, lastUpdatedDate));
  }

  List<List<Movie>> movieList = await Future.wait(futures);

  MovieDatabase db = MovieDatabase();
  await db.openDB();

  for (List<Movie> movies in movieList) {
    movieCount += movies.length;
    for (Movie movie in movies) {
      db.insertMovie(movie);
    }
  }

  await setLastUpdatedDate(updateDate.year, updateDate.month);

  return movieCount;
}
